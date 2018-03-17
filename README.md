# EctoAbstractTableTest

This is a sample Ecto application of using abstract tables for polymorphic associations.  
Although there is [a document](https://hexdocs.pm/ecto/Ecto.Schema.html#belongs_to/3-polymorphic-associations) about this, I was not sure what the docs exactly meant. It seemed not so much suitable for a replacement of usual polymorphic associations, like when you want to list all comments of a user dispite what the comment was posted to.

In this simple implemention, you can see what the example will look like when the document says:
> Alternatively, because Ecto does not tie a schema to a given table, we can use separate tables for each association.

Also you can see (in the example below) that you cannot get all comments easily, as you may predict.

This sample uses Postgres, and there's a default db name written in `config.exs`, so be careful not to overwrite existing databases.

### Examples

```elixir
⟩ iex -S mix
Erlang/OTP 20 [erts-9.0] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false]

Interactive Elixir (1.6.1) - press Ctrl+C to exit (type h() ENTER for help)

iex(1)> alias EctoAbstractTableTest.Blog
EctoAbstractTableTest.Blog

iex(2)> {:ok, post} = Blog.create_post

00:59:41.074 [debug] QUERY OK db=0.2ms
begin []

00:59:41.102 [debug] QUERY OK db=2.2ms
INSERT INTO "posts" ("inserted_at","updated_at") VALUES ($1,$2) RETURNING "id" [{{2018, 3, 17}, {15, 59, 41, 85529}}, {{2018, 3, 17}, {15, 59, 41, 87788}}]

00:59:41.125 [debug] QUERY OK db=23.4ms
commit []
{:ok,
 %EctoAbstractTableTest.Blog.Post{
   __meta__: #Ecto.Schema.Metadata<:loaded, "posts">,
   comments: #Ecto.Association.NotLoaded<association :comments is not loaded>,
   id: 1,
   inserted_at: ~N[2018-03-17 15:59:41.085529],
   updated_at: ~N[2018-03-17 15:59:41.087788]
 }}

iex(3)> post |> Blog.create_comment()

00:59:44.942 [debug] QUERY OK db=9.5ms queue=2.6ms
INSERT INTO "posts_comments" ("assoc_id","inserted_at","updated_at") VALUES ($1,$2,$3) RETURNING "id" [1, {{2018, 3, 17}, {15, 59, 44, 929944}}, {{2018, 3, 17}, {15, 59, 44, 929999}}]
{:ok,
 %EctoAbstractTableTest.Blog.Comment{
   __meta__: #Ecto.Schema.Metadata<:loaded, "posts_comments">,
   assoc_id: 1,
   id: 1,
   inserted_at: ~N[2018-03-17 15:59:44.929944],
   updated_at: ~N[2018-03-17 15:59:44.929999]
 }}

iex(4)> post |> Blog.list_comments()

00:59:57.065 [debug] QUERY OK source="posts_comments" db=1.0ms queue=0.1ms
SELECT p0."id", p0."assoc_id", p0."inserted_at", p0."updated_at" FROM "posts_comments" AS p0 WHERE (p0."assoc_id" = $1) [1]
[
  %EctoAbstractTableTest.Blog.Comment{
    __meta__: #Ecto.Schema.Metadata<:loaded, "posts_comments">,
    assoc_id: 1,
    id: 1,
    inserted_at: ~N[2018-03-17 15:59:44.929944],
    updated_at: ~N[2018-03-17 15:59:44.929999]
  }
]

iex(5)> Blog.list_comments

01:00:05.942 [debug] QUERY ERROR source="abstract table: comments" db=10.5ms queue=0.2ms
SELECT a0."id", a0."assoc_id", a0."inserted_at", a0."updated_at" FROM "abstract table: comments" AS a0 []
** (Postgrex.Error) ERROR 42P01 (undefined_table): relation "abstract table: comments" does not exist
    (ecto) lib/ecto/adapters/sql.ex:431: Ecto.Adapters.SQL.execute_and_cache/7
    (ecto) lib/ecto/repo/queryable.ex:133: Ecto.Repo.Queryable.execute/5
    (ecto) lib/ecto/repo/queryable.ex:37: Ecto.Repo.Queryable.all/4
```

### functions
lies in [lib/ecto_abstract_table_test/blog/blog.ex](lib/ecto_abstract_table_test/blog/blog.ex)
