.class public Lchat/ola/vn/m/s;
.super Lchat/ola/vn/m/q;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Lchat/ola/vn/b/j$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/m/s$a;
    }
.end annotation


# instance fields
.field private b:Landroid/widget/ListView;

.field private d:Lcom/mg/ola/common/widget/OlaViewPager;

.field private e:Lchat/ola/vn/b/g;

.field private f:Lchat/ola/vn/m/s$a;

.field private g:Ljava/lang/Runnable;

.field private h:Landroid/view/View;

.field private i:Landroid/view/View;

.field private j:Landroid/widget/LinearLayout;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/q;-><init>()V

    new-instance v0, Lchat/ola/vn/m/s$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/s$1;-><init>(Lchat/ola/vn/m/s;)V

    iput-object v0, p0, Lchat/ola/vn/m/s;->g:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/s;->d:Lcom/mg/ola/common/widget/OlaViewPager;

    return-object p0
.end method

.method private a(Landroid/widget/ListView;)V
    .locals 9

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->u()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, -0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v4, 0x7f0b00db

    invoke-virtual {v0, v4, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v4, 0x7f0902fb

    invoke-virtual {v0, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/LinearLayout;

    iput-object v4, p0, Lchat/ola/vn/m/s;->j:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lchat/ola/vn/m/s;->j:Landroid/widget/LinearLayout;

    const/16 v5, 0x8

    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->setVisibility(I)V

    const v4, 0x7f0905eb

    invoke-virtual {v0, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/common/widget/OlaViewPager;

    iput-object v4, p0, Lchat/ola/vn/m/s;->d:Lcom/mg/ola/common/widget/OlaViewPager;

    const v4, 0x7f0903af

    invoke-virtual {v0, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setStrokeWidth(F)V

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f070136

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v5

    int-to-float v5, v5

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setRadius(F)V

    invoke-virtual {v4, v2}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setStrokeColor(I)V

    sget v5, Lchat/ola/vn/f;->i:I

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setPageColor(I)V

    invoke-virtual {v4, v2}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setFillColor(I)V

    new-instance v5, Lchat/ola/vn/m/s$a;

    invoke-direct {v5, p0, v3}, Lchat/ola/vn/m/s$a;-><init>(Lchat/ola/vn/m/s;Lchat/ola/vn/m/s$1;)V

    iput-object v5, p0, Lchat/ola/vn/m/s;->f:Lchat/ola/vn/m/s$a;

    iget-object v5, p0, Lchat/ola/vn/m/s;->d:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object v6, p0, Lchat/ola/vn/m/s;->f:Lchat/ola/vn/m/s$a;

    invoke-virtual {v5, v6}, Lcom/mg/ola/common/widget/OlaViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    iget-object v5, p0, Lchat/ola/vn/m/s;->d:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object v6, p0, Lchat/ola/vn/m/s;->g:Ljava/lang/Runnable;

    const-wide/16 v7, 0x1388

    invoke-virtual {v5, v6, v7, v8}, Lcom/mg/ola/common/widget/OlaViewPager;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v5, p0, Lchat/ola/vn/m/s;->d:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setViewPager(Lcom/mg/ola/common/widget/OlaViewPager;)V

    new-instance v5, Lchat/ola/vn/m/s$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/s$2;-><init>(Lchat/ola/vn/m/s;)V

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/pager/indicator/CirclePageIndicator;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    invoke-virtual {p1, v0, v3, v1}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;Ljava/lang/Object;Z)V

    :cond_0
    new-instance v0, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-direct {v0, v4}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v4, Landroid/widget/AbsListView$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f070141

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v5

    invoke-direct {v4, v2, v5}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v4}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1, v0, v3, v1}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;Ljava/lang/Object;Z)V

    new-instance v0, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-direct {v0, v4}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v4, Landroid/widget/AbsListView$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f0700ed

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v5

    invoke-direct {v4, v2, v5}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v4}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1, v0, v3, v1}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Lchat/ola/vn/entity/e;Lchat/ola/vn/entity/e;)V
    .locals 2

    if-nez p2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/e;->c(Lchat/ola/vn/entity/e;)V

    :try_start_0
    invoke-virtual {p2}, Lchat/ola/vn/entity/e;->p()Z

    move-result p1

    if-nez p1, :cond_3

    invoke-virtual {p2}, Lchat/ola/vn/entity/e;->k()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/s;->h:Landroid/view/View;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/s;->h:Landroid/view/View;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    return-void

    :cond_2
    const/4 p1, 0x1

    invoke-virtual {p2, p1}, Lchat/ola/vn/entity/e;->b(Z)V

    invoke-virtual {p2}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/m/s$9;

    invoke-direct {v1, p0, p2}, Lchat/ola/vn/m/s$9;-><init>(Lchat/ola/vn/m/s;Lchat/ola/vn/entity/e;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->v()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/s;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/s;->g:Ljava/lang/Runnable;

    return-object p0
.end method

.method private b(Lchat/ola/vn/entity/e;)V
    .locals 3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/m/s$5;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/m/s$5;-><init>(Lchat/ola/vn/m/s;Lchat/ola/vn/entity/e;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    :cond_1
    return-void
.end method

.method static synthetic c(Lchat/ola/vn/m/s;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/s;->h:Landroid/view/View;

    return-object p0
.end method


# virtual methods
.method public B()Z
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->l()Lchat/ola/vn/entity/e;

    move-result-object v1

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v3

    if-nez v3, :cond_0

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_2

    const/4 v0, 0x1

    :catch_0
    :cond_2
    return v0
.end method

.method public a(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/a;",
            ">;"
        }
    .end annotation

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/m/s;->c:Ljava/util/ArrayList;

    new-instance p1, Lchat/ola/vn/mediastore/a;

    invoke-direct {p1}, Lchat/ola/vn/mediastore/a;-><init>()V

    const v0, 0x7f080643

    iput v0, p1, Lchat/ola/vn/mediastore/a;->b:I

    const v0, 0x7f090328

    iput v0, p1, Lchat/ola/vn/mediastore/a;->a:I

    new-instance v0, Lchat/ola/vn/m/s$6;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/s$6;-><init>(Lchat/ola/vn/m/s;)V

    iput-object v0, p1, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lchat/ola/vn/mediastore/a;->e:Z

    iget-object v0, p0, Lchat/ola/vn/m/s;->c:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/m/s;->c:Ljava/util/ArrayList;

    return-object p1
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/q;->a(Lchat/ola/vn/entity/e;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->v()V

    return-void
.end method

.method public a_(I)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->l()Lchat/ola/vn/entity/e;

    move-result-object p1

    if-eqz p1, :cond_0

    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/m/s;->b(Lchat/ola/vn/entity/e;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/q;->b(Landroid/os/Bundle;)V

    new-instance p1, Lchat/ola/vn/b/g;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/g;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    iget-object p1, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/g;->a(Lchat/ola/vn/b/j$a;)V

    iget-object p1, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->v()V

    return-void
.end method

.method public c()V
    .locals 2

    :try_start_0
    invoke-super {p0}, Lchat/ola/vn/m/q;->c()V

    iget-object v0, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0902b0

    if-eq v0, v1, :cond_2

    const v1, 0x7f0902f9

    if-eq v0, v1, :cond_1

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "http://mall.ola.vn/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\n "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0, p1, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :pswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "http://mall.ola.vn/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n "

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :pswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->a()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->a(Z)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->b()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v1

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/e;->a(I)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Z)V

    goto :goto_1

    :cond_0
    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/e;->a(Z)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->b()I

    move-result v0

    add-int/2addr v0, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->a(I)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Z)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->I()V

    :goto_2
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->v()V

    return-void

    :pswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->e()Lchat/ola/vn/m/g;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Lchat/ola/vn/m/s$4;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/s$4;-><init>(Lchat/ola/vn/m/s;)V

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void

    :pswitch_4
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->B()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/content/Context;J)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->c()V

    goto :goto_2

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    const/16 v2, 0x65

    if-ne v1, v2, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->e()Lchat/ola/vn/m/g;

    move-result-object p1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lchat/ola/vn/m/s$3;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/s$3;-><init>(Lchat/ola/vn/m/s;)V

    invoke-virtual {p1, v1, v0, v2}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->A()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->G()S

    move-result v3

    invoke-static {v1, p1, v2, v3}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;S)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->z(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0900e5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const/4 p3, 0x0

    const v0, 0x7f0b00dc

    invoke-virtual {p1, v0, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    const v0, 0x7f09032c

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/s;->h:Landroid/view/View;

    const v0, 0x7f090320

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    const/4 v0, 0x0

    const v1, 0x7f0b00d1

    invoke-virtual {p1, v1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    invoke-virtual {p1, v1, v0, p3}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;Ljava/lang/Object;Z)V

    iget-object p1, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    invoke-direct {p0, p1}, Lchat/ola/vn/m/s;->a(Landroid/widget/ListView;)V

    return-object p2
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/s;->c()V

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->e()Lchat/ola/vn/m/g;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Lchat/ola/vn/m/s$7;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/s$7;-><init>(Lchat/ola/vn/m/s;)V

    invoke-virtual {p2, p3, p1, p4}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)Z"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->e()Lchat/ola/vn/m/g;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    new-instance p4, Lchat/ola/vn/m/s$8;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/s$8;-><init>(Lchat/ola/vn/m/s;)V

    invoke-virtual {p2, p3, p1, p4}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return p1
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0902b0

    if-eq v0, v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Lchat/ola/vn/entity/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method protected v()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->m()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->l()Lchat/ola/vn/entity/e;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->p()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-direct {p0, v2, v1}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/entity/e;Lchat/ola/vn/entity/e;)V

    :cond_1
    :goto_0
    iget-object v1, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/g;->a(Ljava/util/List;)V

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->x()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    iget-object v1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->x()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/g;->b(Ljava/util/List;)V

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    iget-object v1, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/g;->a(Ljava/util/List;)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/m/s;->e:Lchat/ola/vn/b/g;

    invoke-virtual {v0}, Lchat/ola/vn/b/g;->notifyDataSetChanged()V

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/m/s;->f:Lchat/ola/vn/m/s$a;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/m/s;->f:Lchat/ola/vn/m/s$a;

    invoke-virtual {v0}, Lchat/ola/vn/m/s$a;->notifyDataSetChanged()V

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/m/s;->h:Landroid/view/View;

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->k()Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/m/s;->h:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_2

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/m/s;->h:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_7
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_3

    :cond_8
    iget-object v0, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_9
    :goto_3
    iget-object v0, p0, Lchat/ola/vn/m/s;->a:Lchat/ola/vn/entity/e;

    iget-object v1, p0, Lchat/ola/vn/m/s;->b:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Landroid/widget/ListView;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/s;->B()Z

    move-result v0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/m/s;->i:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_b
    return-void
.end method
