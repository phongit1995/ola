.class Lchat/ola/vn/b/p$c;
.super Landroid/widget/Filter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/p;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "c"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/p;


# direct methods
.method private constructor <init>(Lchat/ola/vn/b/p;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-direct {p0}, Landroid/widget/Filter;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/b/p;Lchat/ola/vn/b/p$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/p$c;-><init>(Lchat/ola/vn/b/p;)V

    return-void
.end method


# virtual methods
.method protected performFiltering(Ljava/lang/CharSequence;)Landroid/widget/Filter$FilterResults;
    .locals 5

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    move-object v2, v0

    const/4 v0, 0x0

    :goto_0
    :try_start_1
    iget-object v3, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-static {v3}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/p;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ge v0, v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-static {v3}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/p;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-static {v3}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    if-nez v2, :cond_0

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v1}, Ljava/util/ArrayList;-><init>(I)V

    move-object v2, v3

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-static {v3}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/p;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->g()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_2
    move-object v0, v2

    :catch_1
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
    .locals 0

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    iget-object p2, p2, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    check-cast p2, Ljava/util/List;

    invoke-static {p1, p2}, Lchat/ola/vn/b/p;->a(Lchat/ola/vn/b/p;Ljava/util/List;)Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-static {p1}, Lchat/ola/vn/b/p;->b(Lchat/ola/vn/b/p;)Lchat/ola/vn/b/p$a;

    move-result-object p1

    if-eqz p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    iget-object p2, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-static {p2}, Lchat/ola/vn/b/p;->c(Lchat/ola/vn/b/p;)Ljava/util/List;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iget-object p2, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-static {p2}, Lchat/ola/vn/b/p;->b(Lchat/ola/vn/b/p;)Lchat/ola/vn/b/p$a;

    move-result-object p2

    invoke-interface {p2, p1}, Lchat/ola/vn/b/p$a;->a(Ljava/util/List;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/p$c;->a:Lchat/ola/vn/b/p;

    invoke-virtual {p1}, Lchat/ola/vn/b/p;->notifyDataSetChanged()V

    :cond_1
    return-void
.end method
