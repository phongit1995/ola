.class Lchat/ola/vn/view/g$c;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "c"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/i;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/g;

.field private b:Landroid/view/LayoutInflater;

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;"
        }
    .end annotation
.end field

.field private d:Lchat/ola/vn/e/i;


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/g;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g$c;->a:Lchat/ola/vn/view/g;

    invoke-direct {p0, p2}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/g$c;->b:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->b:Landroid/view/LayoutInflater;

    const v1, 0x7f0b0134

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance p2, Lchat/ola/vn/view/g$d;

    iget-object v1, p0, Lchat/ola/vn/view/g$c;->a:Lchat/ola/vn/view/g;

    iget-object v2, p0, Lchat/ola/vn/view/g$c;->a:Lchat/ola/vn/view/g;

    invoke-static {v2}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p2, v1, v0, v2}, Lchat/ola/vn/view/g$d;-><init>(Lchat/ola/vn/view/g;Landroid/view/View;Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, v0

    goto :goto_0

    :catch_0
    move-exception p1

    move-object p2, v0

    goto :goto_1

    :catch_1
    move-exception p1

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/view/g$d;

    iget-object v1, p0, Lchat/ola/vn/view/g$c;->a:Lchat/ola/vn/view/g;

    iget-object v2, p0, Lchat/ola/vn/view/g$c;->a:Lchat/ola/vn/view/g;

    invoke-static {v2}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, p2, v2}, Lchat/ola/vn/view/g$d;-><init>(Lchat/ola/vn/view/g;Landroid/view/View;Ljava/lang/String;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    :cond_1
    :goto_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/g$d;

    invoke-virtual {v0}, Lchat/ola/vn/view/g$d;->a()V

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/g$c;->a(I)Lchat/ola/vn/entity/i;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/g$d;->a(Lchat/ola/vn/entity/i;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_2
    if-nez p2, :cond_2

    return-object p3

    :cond_2
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/entity/i;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/i;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/i;

    invoke-virtual {v2}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_3

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object p1, p0, Lchat/ola/vn/view/g$c;->d:Lchat/ola/vn/e/i;

    if-nez p1, :cond_2

    new-instance p1, Lchat/ola/vn/e/i;

    invoke-direct {p1}, Lchat/ola/vn/e/i;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/g$c;->d:Lchat/ola/vn/e/i;

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/view/g$c;->d:Lchat/ola/vn/e/i;

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    :cond_3
    return-void
.end method

.method public c()Z
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-lez v1, :cond_0

    const/4 v0, 0x1

    :catch_0
    :cond_0
    return v0
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/g$c;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/g$c;->a(I)Lchat/ola/vn/entity/i;

    move-result-object p1

    return-object p1
.end method
