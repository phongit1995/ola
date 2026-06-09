.class Lchat/ola/vn/view/i$f;
.super Landroid/support/v4/view/PagerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "f"
.end annotation


# instance fields
.field a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/view/i$c;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic b:Lchat/ola/vn/view/i;


# direct methods
.method private constructor <init>(Lchat/ola/vn/view/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/i$f;->b:Lchat/ola/vn/view/i;

    invoke-direct {p0}, Landroid/support/v4/view/PagerAdapter;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/view/i;Lchat/ola/vn/view/i$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/i$f;-><init>(Lchat/ola/vn/view/i;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/i$f;->a:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/i$c;

    invoke-virtual {p1}, Lchat/ola/vn/view/i$c;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public destroyItem(Landroid/view/ViewGroup;ILjava/lang/Object;)V
    .locals 0

    :try_start_0
    check-cast p3, Landroid/view/View;

    invoke-virtual {p1, p3}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/view/i;->b()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/i$f;->b:Lchat/ola/vn/view/i;

    invoke-virtual {v0}, Lchat/ola/vn/view/i;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f07012e

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    new-instance v1, Landroid/widget/GridView;

    iget-object v2, p0, Lchat/ola/vn/view/i$f;->b:Lchat/ola/vn/view/i;

    invoke-virtual {v2}, Lchat/ola/vn/view/i;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/widget/GridView;-><init>(Landroid/content/Context;)V

    sget v2, Lchat/ola/vn/e;->c:I

    const/4 v3, 0x5

    div-int/2addr v2, v3

    mul-int/lit8 v4, v0, 0x2

    sub-int/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/widget/GridView;->setColumnWidth(I)V

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/widget/GridView;->setStretchMode(I)V

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    invoke-virtual {v1, v0}, Landroid/widget/GridView;->setVerticalSpacing(I)V

    invoke-virtual {v1, v0}, Landroid/widget/GridView;->setHorizontalSpacing(I)V

    invoke-virtual {v1, v3}, Landroid/widget/GridView;->setNumColumns(I)V

    new-instance v0, Lchat/ola/vn/view/i$c;

    iget-object v2, p0, Lchat/ola/vn/view/i$f;->b:Lchat/ola/vn/view/i;

    iget-object v3, p0, Lchat/ola/vn/view/i$f;->b:Lchat/ola/vn/view/i;

    invoke-virtual {v3}, Lchat/ola/vn/view/i;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Lchat/ola/vn/view/i$c;-><init>(Lchat/ola/vn/view/i;Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/view/i;->b()Ljava/util/List;

    move-result-object v2

    invoke-interface {v2, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/v;

    invoke-virtual {v0, p2}, Lchat/ola/vn/view/i$c;->a(Lchat/ola/vn/entity/v;)V

    invoke-virtual {v1, v0}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v2, p0, Lchat/ola/vn/view/i$f;->a:Ljava/util/Map;

    if-nez v2, :cond_0

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Lchat/ola/vn/view/i$f;->a:Ljava/util/Map;

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/view/i$f;->a:Ljava/util/Map;

    invoke-virtual {p2}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object p2

    invoke-interface {v2, p2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    new-instance p1, Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/view/i$f;->b:Lchat/ola/vn/view/i;

    invoke-virtual {p2}, Lchat/ola/vn/view/i;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1
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
