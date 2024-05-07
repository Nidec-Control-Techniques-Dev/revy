create table
    public.company_annual_sales (
        uuid uuid not null default gen_random_uuid (),
        company_ref uuid not null,
        amount double precision not null,
        multiplier bigint not null default '1'::bigint,
        amount_retrieved_at timestamp with time zone not null default now(),
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint company_annual_sales_pkey primary key (uuid),
        constraint company_annual_sales_company_ref_fkey foreign key (company_ref) references companies (uuid) on update cascade,
        constraint company_annual_sales_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint company_annual_sales_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint company_annual_sales_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;