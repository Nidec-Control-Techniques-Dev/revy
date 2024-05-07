create table
    public.categories (
        uuid uuid not null default gen_random_uuid (),
        name text not null,
        description text not null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint categories_pkey primary key (uuid),
        constraint categories_description_key unique (description),
        constraint categories_name_key unique (name),
        constraint categories_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint categories_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint categories_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;