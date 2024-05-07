create table
    public.states (
        uuid uuid not null default gen_random_uuid (),
        name text not null,
        country_ref uuid not null,
        added_at timestamp with time zone not null default now(),
        added_by_ref uuid not null default auth.uid (),
        updated_at timestamp with time zone not null default now(),
        updated_by_ref uuid not null default auth.uid (),
        deleted_at timestamp with time zone null,
        deleted_by_ref uuid null,
        constraint states_pkey primary key (uuid),
        constraint states_name_key unique (name),
        constraint states_country_ref_fkey foreign key (country_ref) references countries (uuid) on update cascade,
        constraint states_added_by_ref_fkey foreign key (added_by_ref) references auth.users (id) on update cascade,
        constraint states_deleted_by_ref_fkey foreign key (deleted_by_ref) references auth.users (id) on update cascade,
        constraint states_updated_by_ref_fkey foreign key (updated_by_ref) references auth.users (id) on update cascade
    ) tablespace pg_default;