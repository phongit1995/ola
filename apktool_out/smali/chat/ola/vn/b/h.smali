.class public Lchat/ola/vn/b/h;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entry/b;",
        ">;"
    }
.end annotation


# instance fields
.field protected a:Landroid/view/LayoutInflater;

.field protected b:Landroid/view/View$OnClickListener;

.field protected c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field protected d:Landroid/view/View$OnLongClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/h;->a:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    if-nez p2, :cond_1

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/h;->getItemViewType(I)I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    new-instance p1, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/b/h;->b()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/b/h;->a:Landroid/view/LayoutInflater;

    invoke-static {v0, p2, v1}, Lchat/ola/vn/entry/b/i;->a(ILandroid/view/View;Landroid/view/LayoutInflater;)Lchat/ola/vn/entry/b/j;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entry/b/j;->c()Landroid/view/View;

    move-result-object v1

    move-object p2, v1

    goto :goto_0

    :cond_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b/j;

    :goto_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/h;->a(I)Lchat/ola/vn/entry/b;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/b/h;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lchat/ola/vn/b/h;->d:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View$OnLongClickListener;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/b/j;->a(Lchat/ola/vn/entry/b;)V

    invoke-virtual {v0}, Lchat/ola/vn/entry/b/j;->b()V

    invoke-virtual {v0}, Lchat/ola/vn/entry/b/j;->a()V

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/b/j;->a(Z)V

    invoke-virtual {p0, p1, v0, v1}, Lchat/ola/vn/b/h;->a(ILchat/ola/vn/entry/b/j;Lchat/ola/vn/entry/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    if-nez p2, :cond_2

    return-object p3

    :cond_2
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/entry/b;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/h;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(ILchat/ola/vn/entry/b/j;Lchat/ola/vn/entry/b;)V
    .locals 0

    return-void
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/h;->b:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/h;->d:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/b/h;->c:Ljava/util/List;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/h;->c:Ljava/util/List;

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/h;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 0

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/h;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->d()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/16 v0, 0xa

    return v0
.end method
