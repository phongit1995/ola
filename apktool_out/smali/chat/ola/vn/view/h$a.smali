.class Lchat/ola/vn/view/h$a;
.super Landroid/support/v4/view/PagerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/h;


# direct methods
.method private constructor <init>(Lchat/ola/vn/view/h;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-direct {p0}, Landroid/support/v4/view/PagerAdapter;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/view/h;Lchat/ola/vn/view/h$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/h$a;-><init>(Lchat/ola/vn/view/h;)V

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

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public getCount()I
    .locals 1

    const/4 v0, 0x6

    return v0
.end method

.method public instantiateItem(Landroid/view/ViewGroup;I)Ljava/lang/Object;
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v0}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0700e9

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    const/4 v1, -0x1

    const/4 v2, 0x1

    const v3, 0x7f07012e

    packed-switch p2, :pswitch_data_0

    goto/16 :goto_0

    :pswitch_0
    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    new-instance v3, Landroid/widget/GridView;

    iget-object v4, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v4}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/GridView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setColumnWidth(I)V

    invoke-virtual {v3, v2}, Landroid/widget/GridView;->setVerticalFadingEdgeEnabled(Z)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setHorizontalSpacing(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setVerticalSpacing(I)V

    invoke-virtual {v3, v1}, Landroid/widget/GridView;->setNumColumns(I)V

    new-instance p2, Lchat/ola/vn/b/ab;

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v0}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/r/c;->b:[Lchat/ola/vn/entry/h;

    invoke-direct {p2, v0, v1}, Lchat/ola/vn/b/ab;-><init>(Landroid/content/Context;[Lchat/ola/vn/entry/h;)V

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ab;->a(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p1, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v3

    :pswitch_1
    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    new-instance v3, Landroid/widget/GridView;

    iget-object v4, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v4}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/GridView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setColumnWidth(I)V

    invoke-virtual {v3, v2}, Landroid/widget/GridView;->setVerticalFadingEdgeEnabled(Z)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setHorizontalSpacing(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setVerticalSpacing(I)V

    invoke-virtual {v3, v1}, Landroid/widget/GridView;->setNumColumns(I)V

    new-instance p2, Lchat/ola/vn/b/ab;

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v0}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/r/c;->c:[Lchat/ola/vn/entry/h;

    invoke-direct {p2, v0, v1}, Lchat/ola/vn/b/ab;-><init>(Landroid/content/Context;[Lchat/ola/vn/entry/h;)V

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ab;->a(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p1, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v3

    :pswitch_2
    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    new-instance v3, Landroid/widget/GridView;

    iget-object v4, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v4}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/GridView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setColumnWidth(I)V

    invoke-virtual {v3, v2}, Landroid/widget/GridView;->setVerticalFadingEdgeEnabled(Z)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setHorizontalSpacing(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setVerticalSpacing(I)V

    invoke-virtual {v3, v1}, Landroid/widget/GridView;->setNumColumns(I)V

    new-instance p2, Lchat/ola/vn/b/ab;

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v0}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/r/c;->e:[Lchat/ola/vn/entry/h;

    invoke-direct {p2, v0, v1}, Lchat/ola/vn/b/ab;-><init>(Landroid/content/Context;[Lchat/ola/vn/entry/h;)V

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ab;->a(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p1, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v3

    :pswitch_3
    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    new-instance v3, Landroid/widget/GridView;

    iget-object v4, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v4}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/GridView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setColumnWidth(I)V

    invoke-virtual {v3, v2}, Landroid/widget/GridView;->setVerticalFadingEdgeEnabled(Z)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setHorizontalSpacing(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setVerticalSpacing(I)V

    invoke-virtual {v3, v1}, Landroid/widget/GridView;->setNumColumns(I)V

    new-instance p2, Lchat/ola/vn/b/ab;

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v0}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/r/c;->d:[Lchat/ola/vn/entry/h;

    invoke-direct {p2, v0, v1}, Lchat/ola/vn/b/ab;-><init>(Landroid/content/Context;[Lchat/ola/vn/entry/h;)V

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ab;->a(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p1, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v3

    :pswitch_4
    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    new-instance v3, Landroid/widget/GridView;

    iget-object v4, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v4}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/GridView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setColumnWidth(I)V

    invoke-virtual {v3, v2}, Landroid/widget/GridView;->setVerticalFadingEdgeEnabled(Z)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setHorizontalSpacing(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setVerticalSpacing(I)V

    invoke-virtual {v3, v1}, Landroid/widget/GridView;->setNumColumns(I)V

    new-instance p2, Lchat/ola/vn/b/ab;

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v0}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/r/c;->a:[Lchat/ola/vn/entry/h;

    invoke-direct {p2, v0, v1}, Lchat/ola/vn/b/ab;-><init>(Landroid/content/Context;[Lchat/ola/vn/entry/h;)V

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ab;->a(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p1, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-object v3

    :pswitch_5
    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    new-instance v3, Landroid/widget/GridView;

    iget-object v4, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v4}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/widget/GridView;-><init>(Landroid/content/Context;)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setColumnWidth(I)V

    invoke-virtual {v3, v2}, Landroid/widget/GridView;->setVerticalFadingEdgeEnabled(Z)V

    invoke-virtual {v3, v0}, Landroid/widget/GridView;->setFadingEdgeLength(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setHorizontalSpacing(I)V

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setVerticalSpacing(I)V

    invoke-virtual {v3, v1}, Landroid/widget/GridView;->setNumColumns(I)V

    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    new-instance v0, Lchat/ola/vn/b/ab;

    iget-object v1, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {v1}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/b/ab;-><init>(Landroid/content/Context;)V

    iput-object v0, p2, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-static {}, Lchat/ola/vn/view/h;->b()Ljava/util/List;

    move-result-object p2

    if-nez p2, :cond_0

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    invoke-static {p2}, Lchat/ola/vn/view/h;->a(Ljava/util/List;)Ljava/util/List;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/e;->x()Ljava/util/List;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/view/h;->b()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    iget-object p2, p2, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-static {}, Lchat/ola/vn/view/h;->b()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ab;->a(Ljava/util/List;)V

    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    iget-object p2, p2, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    iget-object v0, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ab;->a(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    iget-object p2, p2, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-virtual {v3, p2}, Landroid/widget/GridView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p1, v3}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    new-instance p1, Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/view/h$a;->a:Lchat/ola/vn/view/h;

    invoke-virtual {p2}, Lchat/ola/vn/view/h;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
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
