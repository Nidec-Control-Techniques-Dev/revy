create table
    public.company_addresses (
        uuid uuid not null default gen_random_uuid (),
        company_ref uuid not null,
        country_ref uuid not null,
        state_ref uuid not null,
        full_text text not null,
        latitude double precision not null,
        longitude double precision not null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint company_addresses_pkey primary key (uuid),
        constraint company_addresses_full_text_key unique (full_text),
        constraint company_addresses_company_ref_fkey foreign key (company_ref) references companies (uuid) on update cascade,
        constraint company_addresses_country_ref_fkey foreign key (country_ref) references countries (uuid) on update cascade,
        constraint company_addresses_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint company_addresses_state_ref_fkey foreign key (state_ref) references states (uuid) on update cascade,
        constraint company_addresses_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint company_addresses_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;