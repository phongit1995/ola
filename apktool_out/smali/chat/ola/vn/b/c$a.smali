.class Lchat/ola/vn/b/c$a;
.super Landroid/widget/Filter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/c;


# direct methods
.method private constructor <init>(Lchat/ola/vn/b/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-direct {p0}, Landroid/widget/Filter;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/b/c;Lchat/ola/vn/b/c$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/c$a;-><init>(Lchat/ola/vn/b/c;)V

    return-void
.end method


# virtual methods
.method protected performFiltering(Ljava/lang/CharSequence;)Landroid/widget/Filter$FilterResults;
    .locals 5

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-static {v3}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_1

    iget-object v3, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-static {v3}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    new-instance v3, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-direct {v3}, Lchat/ola/vn/entity/OlaCheckInActionEntity;-><init>()V

    iget-object v4, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-static {v4}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;)Ljava/util/List;

    move-result-object v4

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v3, v4}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v2, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-static {v2}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-static {v2}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v2, p1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    new-instance v2, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-direct {v2}, Lchat/ola/vn/entity/OlaCheckInActionEntity;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-static {v3}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :catch_0
    :cond_3
    new-instance p1, Landroid/widget/Filter$FilterResults;

    invoke-direct {p1}, Landroid/widget/Filter$FilterResults;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    iput v1, p1, Landroid/widget/Filter$FilterResults;->count:I

    iput-object v0, p1, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    return-object p1
.end method

.method protected publishResults(Ljava/lang/CharSequence;Landroid/widget/Filter$FilterResults;)V
    .locals 1

    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    new-instance v0, Ljava/util/ArrayList;

    iget-object p2, p2, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    check-cast p2, Ljava/util/List;

    invoke-direct {v0, p2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {p1, v0}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;Ljava/util/List;)Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-virtual {p1}, Lchat/ola/vn/b/c;->notifyDataSetChanged()V

    return-void

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_1
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    new-instance p2, Ljava/util/ArrayList;

    iget-object v0, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-static {v0}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;)Ljava/util/List;

    move-result-object v0

    invoke-direct {p2, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {p1, p2}, Lchat/ola/vn/b/c;->a(Lchat/ola/vn/b/c;Ljava/util/List;)Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/b/c$a;->a:Lchat/ola/vn/b/c;

    invoke-virtual {p1}, Lchat/ola/vn/b/c;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method
