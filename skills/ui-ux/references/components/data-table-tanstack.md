# Data Table với TanStack Table (React Table v8)

> Hướng dẫn và code mẫu chuẩn ráp giao diện bảng của `lucas:ui-ux` với thư viện **TanStack Table v8**.
> Đảm bảo các quy chuẩn:
> - Spacing nhịp nhàng, chiều cao dòng tối thiểu 44px (`list-row.md`).
> - Tiêu đề cột sắp xếp được (`sortable-header.md`).
> - Trạng thái dòng được chọn mang nền `bg-secondary/40` (`rules-state.md`, `I7`).
> - Không cắt chữ làm mất số tiền, mã đơn hoặc số lượng (`rules-type.md`, `T7`).
> - Phân trang đầy đủ: số dòng/trang, thông tin trang hiện tại, nút điều hướng.

---

## 1. Cấu trúc bảng hoàn chỉnh

```
┌────────────────────────────────────────────────────────┐
│ Toolbar: [ Ô tìm kiếm ] [ Bộ lọc Trạng thái ] [ Cột ⚙ ]│
├────────────────────────────────────────────────────────┤
│ [ Thanh tác vụ hàng loạt: Đã chọn 3 mục | Nút Xoá... ] │ <- chỉ hiện khi có chọn
├────────────────────────────────────────────────────────┤
│ [ ]  MÃ ĐƠN     KHÁCH HÀNG      NGÀY TẠO    TỔNG TIỀN  │
├────────────────────────────────────────────────────────┤
│ [ ]  #ORD-102   Nguyễn Văn A    01/10/2026   1,500,000đ│
│ [✓]  #ORD-103   Trần Thị B      01/10/2026     850,000đ│ <- bg-secondary
│ [ ]  #ORD-104   Lê Hoàng C      30/09/2026   2,100,000đ│
├────────────────────────────────────────────────────────┤
│ Hiển thị 1–10 của 128 dòng     [<] [1] [2] [3] ... [>] │
└────────────────────────────────────────────────────────┘
```

---

## 2. Mã nguồn Component React + TanStack Table

```tsx
"use client";

import React, { useState } from "react";
import {
  useReactTable,
  getCoreRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  getFilteredRowModel,
  ColumnDef,
  flexRender,
  SortingState,
} from "@tanstack/react-table";
import { ArrowUpDown, ArrowUp, ArrowDown, ChevronLeft, ChevronRight, Search } from "lucide-react";

interface DataTableProps<TData, TValue> {
  columns: ColumnDef<TData, TValue>[];
  data: TData[];
  isLoading?: boolean;
}

export function DataTable<TData, TValue>({
  columns,
  data,
  isLoading = false,
}: DataTableProps<TData, TValue>) {
  const [sorting, setSorting] = useState<SortingState>([]);
  const [globalFilter, setGlobalFilter] = useState("");
  const [rowSelection, setRowSelection] = useState({});

  const table = useReactTable({
    data,
    columns,
    state: {
      sorting,
      globalFilter,
      rowSelection,
    },
    onSortingChange: setSorting,
    onGlobalFilterChange: setGlobalFilter,
    onRowSelectionChange: setRowSelection,
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
  });

  const selectedCount = Object.keys(rowSelection).length;

  return (
    <div className="w-full space-y-3">
      {/* 1. Thanh công cụ phía trên (Toolbar) */}
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="relative w-full max-w-sm">
          <Search className="absolute left-3 top-1/2 size-4 -translate-y-1/2 text-muted" aria-hidden />
          <input
            type="text"
            value={globalFilter ?? ""}
            onChange={(e) => setGlobalFilter(e.target.value)}
            placeholder="Tìm kiếm trong bảng..."
            className="h-10 w-full rounded-xl border border-border bg-surface pl-9 pr-3 text-sm text-foreground placeholder:text-muted focus:border-primary outline-hidden"
          />
        </div>

        {selectedCount > 0 && (
          <div className="flex items-center gap-2 rounded-xl bg-secondary px-3 py-1.5 text-sm font-medium text-foreground">
            <span>Đã chọn {selectedCount} dòng</span>
            <button
              type="button"
              onClick={() => setRowSelection({})}
              className="text-xs text-muted hover:text-foreground"
            >
              Bỏ chọn
            </button>
          </div>
        )}
      </div>

      {/* 2. Khung bảng dữ liệu (Bọc overflow-x-auto để tránh tràn màn hình mobile) */}
      <div className="overflow-hidden rounded-2xl border border-border bg-surface shadow-xs">
        <div className="overflow-x-auto">
          <table className="w-full text-left text-sm">
            <thead className="border-b border-border bg-surface-hover/50 text-xs font-semibold uppercase tracking-wider text-muted">
              {table.getHeaderGroups().map((headerGroup) => (
                <tr key={headerGroup.id}>
                  {headerGroup.headers.map((header) => {
                    const canSort = header.column.getCanSort();
                    const isSorted = header.column.getIsSorted();

                    return (
                      <th key={header.id} className="h-11 px-4 py-2 font-medium">
                        {header.isPlaceholder ? null : canSort ? (
                          <button
                            type="button"
                            onClick={header.column.getToggleSortingHandler()}
                            className="inline-flex cursor-pointer items-center gap-1.5 text-muted hover:text-foreground outline-hidden"
                          >
                            {flexRender(header.column.columnDef.header, header.getContext())}
                            {isSorted === "asc" ? (
                              <ArrowUp className="size-3.5 text-primary" />
                            ) : isSorted === "desc" ? (
                              <ArrowDown className="size-3.5 text-primary" />
                            ) : (
                              <ArrowUpDown className="size-3.5 opacity-40" />
                            )}
                          </button>
                        ) : (
                          flexRender(header.column.columnDef.header, header.getContext())
                        )}
                      </th>
                    );
                  })}
                </tr>
              ))}
            </thead>
            <tbody className="divide-y divide-border">
              {isLoading ? (
                // Skeleton loading rows
                Array.from({ length: 5 }).map((_, i) => (
                  <tr key={i} className="animate-pulse">
                    {columns.map((_, colIndex) => (
                      <td key={colIndex} className="h-12 px-4 py-3">
                        <div className="h-4 w-3/4 rounded bg-surface-hover" />
                      </td>
                    ))}
                  </tr>
                ))
              ) : table.getRowModel().rows.length > 0 ? (
                table.getRowModel().rows.map((row) => (
                  <tr
                    key={row.id}
                    className={`transition-colors hover:bg-surface-hover/70 ${
                      row.getIsSelected() ? "bg-secondary/40 font-medium" : ""
                    }`}
                  >
                    {row.getVisibleCells().map((cell) => (
                      <td key={cell.id} className="h-12 px-4 py-3 text-foreground [overflow-wrap:anywhere]">
                        {flexRender(cell.column.columnDef.cell, cell.getContext())}
                      </td>
                    ))}
                  </tr>
                ))
              ) : (
                // Empty state
                <tr>
                  <td colSpan={columns.length} className="h-32 text-center text-muted">
                    Không tìm thấy dữ liệu phù hợp.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* 3. Phân trang (Pagination Bar) */}
      <div className="flex flex-wrap items-center justify-between gap-3 px-1 py-1 text-sm text-muted">
        <div>
          Trang {table.getState().pagination.pageIndex + 1} / {table.getPageCount() || 1} • Tổng cộng{" "}
          {table.getFilteredRowModel().rows.length} mục
        </div>

        <div className="flex items-center gap-2">
          <select
            value={table.getState().pagination.pageSize}
            onChange={(e) => table.setPageSize(Number(e.target.value))}
            className="h-9 rounded-lg border border-border bg-surface px-2 text-xs text-foreground outline-hidden"
          >
            {[10, 20, 50, 100].map((size) => (
              <option key={size} value={size}>
                {size} dòng / trang
              </option>
            ))}
          </select>

          <button
            type="button"
            onClick={() => table.previousPage()}
            disabled={!table.getCanPreviousPage()}
            className="inline-flex size-9 cursor-pointer items-center justify-center rounded-lg border border-border bg-surface text-foreground transition-colors hover:bg-surface-hover disabled:cursor-not-allowed disabled:opacity-40 outline-hidden"
            aria-label="Trang trước"
          >
            <ChevronLeft className="size-4" />
          </button>

          <button
            type="button"
            onClick={() => table.nextPage()}
            disabled={!table.getCanNextPage()}
            className="inline-flex size-9 cursor-pointer items-center justify-center rounded-lg border border-border bg-surface text-foreground transition-colors hover:bg-surface-hover disabled:cursor-not-allowed disabled:opacity-40 outline-hidden"
            aria-label="Trang tiếp theo"
          >
            <ChevronRight className="size-4" />
          </button>
        </div>
      </div>
    </div>
  );
}
```
