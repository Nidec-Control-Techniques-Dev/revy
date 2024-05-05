create table
    public.currencies (
        uuid uuid not null default gen_random_uuid (),
        country_ref uuid not null,
        name text not null,
        code character varying(3) not null,
        rate double precision not null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint currencies_pkey primary key (uuid),
        constraint currencies_code_key unique (code),
        constraint currencies_country_ref_key unique (country_ref),
        constraint currencies_name_key unique (name),
        constraint currencies_country_ref_fkey foreign key (country_ref) references countries (uuid) on update cascade,
        constraint currencies_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint currencies_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint currencies_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;