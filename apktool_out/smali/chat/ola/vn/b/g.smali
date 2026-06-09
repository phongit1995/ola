.class public Lchat/ola/vn/b/g;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/e;",
        ">;"
    }
.end annotation


# instance fields
.field protected a:Landroid/view/LayoutInflater;

.field protected b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field protected c:Landroid/view/View$OnClickListener;

.field protected d:Landroid/view/View$OnLongClickListener;

.field private g:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/g;->a:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/g;->a(I)Lchat/ola/vn/entity/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/b/g;->a:Landroid/view/LayoutInflater;

    invoke-static {p2, p3, v1}, Lchat/ola/vn/entry/b/h;->a(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;I)Landroid/view/View;

    move-result-object p2

    :cond_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/entry/b/h;

    iget-object v2, p0, Lchat/ola/vn/b/g;->c:Landroid/view/View$OnClickListener;

    invoke-virtual {p3, v2}, Lchat/ola/vn/entry/b/h;->a(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lchat/ola/vn/b/g;->d:Landroid/view/View$OnLongClickListener;

    invoke-virtual {p3, v2}, Lchat/ola/vn/entry/b/h;->a(Landroid/view/View$OnLongClickListener;)V

    invoke-virtual {p3, v0}, Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/entity/e;)V

    :try_start_0
    iget-object v0, p3, Lchat/ola/vn/entry/b/h;->b:Landroid/view/View;

    if-eqz v0, :cond_7

    const/16 v0, 0x64

    if-eq v1, v0, :cond_1

    const/16 v0, 0x66

    if-eq v1, v0, :cond_1

    const/16 v0, 0x65

    if-eq v1, v0, :cond_1

    const/4 v0, 0x6

    if-ne v1, v0, :cond_7

    :cond_1
    const v0, 0x7f0800ac

    if-nez p1, :cond_3

    :cond_2
    :goto_0
    iget-object p1, p3, Lchat/ola/vn/entry/b/h;->b:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundResource(I)V

    return-object p2

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/b/g;->getCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    const v2, 0x7f0800a9

    if-ne p1, v1, :cond_4

    :goto_1
    iget-object p1, p3, Lchat/ola/vn/entry/b/h;->b:Landroid/view/View;

    invoke-virtual {p1, v2}, Landroid/view/View;->setBackgroundResource(I)V

    return-object p2

    :cond_4
    add-int/lit8 v1, p1, -0x1

    invoke-virtual {p0, v1}, Lchat/ola/vn/b/g;->a(I)Lchat/ola/vn/entity/e;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    add-int/lit8 p1, p1, 0x1

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/g;->a(I)Lchat/ola/vn/entity/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->E()I

    move-result p1

    const/4 v3, 0x2

    if-eq v1, v3, :cond_2

    if-eqz v1, :cond_2

    const/4 v4, -0x6

    if-eq v1, v4, :cond_2

    const/4 v4, -0x2

    if-ne v1, v4, :cond_5

    goto :goto_0

    :cond_5
    if-ne p1, v3, :cond_6

    goto :goto_1

    :cond_6
    iget-object p1, p3, Lchat/ola/vn/entry/b/h;->b:Landroid/view/View;

    const p3, 0x7f0800a8

    invoke-virtual {p1, p3}, Landroid/view/View;->setBackgroundResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_7
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/entity/e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    return-object p1
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/g;->c:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/g;->d:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    return-void
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/b/g;->g:I

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_2
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_0

    :cond_3
    return-void
.end method

.method public getCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/g;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/g;->a(I)Lchat/ola/vn/entity/e;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 1

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/g;->a(I)Lchat/ola/vn/entity/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->E()I

    move-result p1

    invoke-static {p1}, Lchat/ola/vn/entry/b/h;->a(I)I

    move-result p1

    iget v0, p0, Lchat/ola/vn/b/g;->g:I

    add-int/2addr p1, v0

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    invoke-static {}, Lchat/ola/vn/entry/b/h;->a()I

    move-result v0

    return v0
.end method
