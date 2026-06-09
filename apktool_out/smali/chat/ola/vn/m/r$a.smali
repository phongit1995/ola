.class Lchat/ola/vn/m/r$a;
.super Landroid/support/v4/view/PagerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/r;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/r;


# direct methods
.method private constructor <init>(Lchat/ola/vn/m/r;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/r$a;->a:Lchat/ola/vn/m/r;

    invoke-direct {p0}, Landroid/support/v4/view/PagerAdapter;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/m/r;Lchat/ola/vn/m/r$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/r$a;-><init>(Lchat/ola/vn/m/r;)V

    return-void
.end method


# virtual methods
.method public destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 0

    :try_start_0
    check-cast p3, Landroid/view/View;

    invoke-virtual {p1, p3}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public getCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/r$a;->a:Lchat/ola/vn/m/r;

    iget-object v0, v0, Lchat/ola/vn/m/r;->a:Lchat/ola/vn/entity/e;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/r$a;->a:Lchat/ola/vn/m/r;

    iget-object v0, v0, Lchat/ola/vn/m/r;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->u()I

    move-result v0

    return v0
.end method

.method public instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0x10
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/m/r$a;->a:Lchat/ola/vn/m/r;

    iget-object v0, v0, Lchat/ola/vn/m/r;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0, p2}, Lchat/ola/vn/entity/e;->g(I)Lchat/ola/vn/entity/e;

    move-result-object p2

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-virtual {p2}, Lchat/ola/vn/entity/e;->j()Ljava/util/List;

    move-result-object v1

    if-nez v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-static {v0, p1, v1}, Lchat/ola/vn/entry/b/h;->a(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/b/h;

    iget-object v2, p0, Lchat/ola/vn/m/r$a;->a:Lchat/ola/vn/m/r;

    invoke-virtual {v1, v2}, Lchat/ola/vn/entry/b/h;->a(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v1, p2}, Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/entity/e;)V

    iget-object p2, v1, Lchat/ola/vn/entry/b/h;->a:Landroid/view/View;

    if-eqz p2, :cond_1

    iget-object p2, v1, Lchat/ola/vn/entry/b/h;->a:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {p2, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v0
.end method

.method public isViewFromObject(Landroid/view/View;Ljava/lang/Object;)Z
    .locals 0

    if-ne p1, p2, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method
