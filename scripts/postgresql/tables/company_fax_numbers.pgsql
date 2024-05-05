create table
    public.company_fax_numbers (
        uuid uuid not null default gen_random_uuid (),
        company_ref uuid not null,
        number character varying(25) not null,
        is_verified boolean not null default false,
        verfied_at timestamp with time zone null,
        verified_by_ref uuid null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint company_fax_numbers_pkey primary key (uuid),
        constraint company_fax_numbers_number_key unique (number),
        constraint company_fax_numbers_company_ref_fkey foreign key (company_ref) references companies (uuid) on update cascade,
        constraint company_fax_numbers_verified_by_ref_fkey foreign key (verified_by_ref) references auth.users (id) on update cascade,
        constraint company_fax_numbers_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint company_fax_numbers_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint company_fax_numbers_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;