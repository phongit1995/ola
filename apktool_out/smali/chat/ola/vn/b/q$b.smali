.class public Lchat/ola/vn/b/q$b;
.super Landroid/widget/Filter;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation

.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/q;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/q;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/q;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    invoke-direct {p0}, Landroid/widget/Filter;-><init>()V

    return-void
.end method

.method private a(Landroid/widget/Filter$FilterResults;Ljava/lang/String;Ljava/util/ArrayList;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/Filter$FilterResults;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/entity/x;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_a

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/4 v1, 0x1

    invoke-virtual {p2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {p3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_0
    :goto_0
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_9

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/x;

    const/16 v4, 0x40

    if-ne v0, v4, :cond_6

    iget-byte v4, v3, Lchat/ola/vn/entity/x;->a:B

    if-nez v4, :cond_0

    iget-object v4, v3, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    :cond_1
    iget-object v5, v3, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    if-eqz v5, :cond_2

    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_1

    :cond_2
    const-string v5, ""

    :goto_1
    invoke-virtual {v5, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    :goto_2
    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    invoke-virtual {v4, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_4

    goto :goto_2

    :cond_4
    invoke-virtual {v4, p2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_5

    goto :goto_2

    :cond_5
    if-eqz v5, :cond_0

    invoke-virtual {v5, p2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_2

    :cond_6
    const/16 v4, 0x23

    if-ne v0, v4, :cond_0

    iget-byte v4, v3, Lchat/ola/vn/entity/x;->a:B

    if-ne v4, v1, :cond_0

    iget-object v4, v3, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_7

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    :cond_7
    invoke-virtual {v4, p2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_8

    goto :goto_2

    :cond_8
    invoke-virtual {v4, p2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_0

    goto :goto_2

    :cond_9
    iput-object v2, p1, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result p2

    iput p2, p1, Landroid/widget/Filter$FilterResults;->count:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_a
    return-void
.end method


# virtual methods
.method protected performFiltering(Ljava/lang/CharSequence;)Landroid/widget/Filter$FilterResults;
    .locals 5

    new-instance v0, Landroid/widget/Filter$FilterResults;

    invoke-direct {v0}, Landroid/widget/Filter$FilterResults;-><init>()V

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    iget-object v1, v1, Lchat/ola/vn/b/q;->a:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    invoke-static {v1}, Lchat/ola/vn/b/q;->a(Lchat/ola/vn/b/q;)Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    new-instance v3, Ljava/util/ArrayList;

    iget-object v4, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    iget-object v4, v4, Lchat/ola/vn/b/q;->a:Ljava/util/ArrayList;

    invoke-direct {v3, v4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {v2, v3}, Lchat/ola/vn/b/q;->a(Lchat/ola/vn/b/q;Ljava/util/List;)Ljava/util/List;

    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1

    :cond_0
    :goto_0
    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    :cond_1
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    invoke-static {v1}, Lchat/ola/vn/b/q;->a(Lchat/ola/vn/b/q;)Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :try_start_3
    new-instance v2, Ljava/util/ArrayList;

    iget-object v3, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    iget-object v3, v3, Lchat/ola/vn/b/q;->a:Ljava/util/ArrayList;

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    monitor-exit v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :try_start_4
    invoke-direct {p0, v0, p1, v2}, Lchat/ola/vn/b/q$b;->a(Landroid/widget/Filter$FilterResults;Ljava/lang/String;Ljava/util/ArrayList;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    return-object v0

    :catchall_1
    move-exception p1

    :try_start_5
    monitor-exit v1
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw p1

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    invoke-static {p1}, Lchat/ola/vn/b/q;->a(Lchat/ola/vn/b/q;)Ljava/lang/Object;

    move-result-object p1

    monitor-enter p1
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    :try_start_7
    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    iget-object v2, v2, Lchat/ola/vn/b/q;->a:Ljava/util/ArrayList;

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    monitor-exit p1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    :try_start_8
    iput-object v1, v0, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result p1

    iput p1, v0, Landroid/widget/Filter$FilterResults;->count:I
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_0

    return-object v0

    :catchall_2
    move-exception v1

    :try_start_9
    monitor-exit p1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    :try_start_a
    throw v1
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object v0
.end method

.method protected publishResults(Ljava/lang/CharSequence;Landroid/widget/Filter$FilterResults;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    iget-object v0, p2, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    check-cast v0, Ljava/util/List;

    invoke-static {p1, v0}, Lchat/ola/vn/b/q;->a(Lchat/ola/vn/b/q;Ljava/util/List;)Ljava/util/List;

    iget p1, p2, Landroid/widget/Filter$FilterResults;->count:I

    if-lez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    invoke-virtual {p1}, Lchat/ola/vn/b/q;->notifyDataSetChanged()V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/q$b;->a:Lchat/ola/vn/b/q;

    invoke-virtual {p1}, Lchat/ola/vn/b/q;->notifyDataSetInvalidated()V

    return-void
.end method
