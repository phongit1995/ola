.class public Lchat/ola/vn/m/x;
.super Lchat/ola/vn/m/c;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/b/j$a;


# instance fields
.field private d:Lchat/ola/vn/view/OlaListView;

.field private e:Lchat/ola/vn/b/aj;

.field private f:Landroid/view/View;

.field private g:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private h:Z

.field private i:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/m/x;->h:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/x;)Lchat/ola/vn/view/OlaListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    return-object p0
.end method

.method private a(Lchat/ola/vn/entity/t;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/x;->f()Lchat/ola/vn/m/j;

    move-result-object v0

    invoke-virtual {v0, p2}, Lchat/ola/vn/m/j;->e(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    return-void

    :catch_0
    :cond_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/m/x;->f:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    new-instance v0, Lchat/ola/vn/m/x$6;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1}, Lchat/ola/vn/m/x$6;-><init>(Lchat/ola/vn/m/x;Lchat/ola/vn/entity/t;Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->r(Ljava/lang/String;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/x;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/m/x;->i:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/m/x;)Lchat/ola/vn/b/aj;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/m/x;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/x;->f:Landroid/view/View;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/m/x;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/x;->v()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/m/x;)Landroid/support/v4/widget/SwipeRefreshLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/x;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    return-object p0
.end method

.method private j()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/x;->h:Z

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/m/x;->h:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/m/x;->h:Z

    :cond_1
    return-void
.end method

.method private v()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/x;->h:Z

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/m/x;->h:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/m/x;->h:Z

    :cond_1
    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/x;->i:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    if-nez v0, :cond_1

    return v1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->j()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    const/4 v1, 0x1

    :cond_2
    return v1
.end method

.method public a(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 5
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

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/m/x;->c:Ljava/util/ArrayList;

    new-instance v0, Lchat/ola/vn/mediastore/a;

    invoke-direct {v0}, Lchat/ola/vn/mediastore/a;-><init>()V

    const v2, 0x7f08063a

    iput v2, v0, Lchat/ola/vn/mediastore/a;->b:I

    const v2, 0x7f09039d

    iput v2, v0, Lchat/ola/vn/mediastore/a;->a:I

    new-instance v3, Lchat/ola/vn/m/x$4;

    invoke-direct {v3, p0}, Lchat/ola/vn/m/x$4;-><init>(Lchat/ola/vn/m/x;)V

    iput-object v3, v0, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    const/4 v3, 0x1

    iput-boolean v3, v0, Lchat/ola/vn/mediastore/a;->e:Z

    const v4, 0x7f0f0517

    invoke-virtual {p1, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, v0, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/m/x;->c:Ljava/util/ArrayList;

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/mediastore/a;

    invoke-direct {v0}, Lchat/ola/vn/mediastore/a;-><init>()V

    const v4, 0x7f080648

    iput v4, v0, Lchat/ola/vn/mediastore/a;->b:I

    iput v2, v0, Lchat/ola/vn/mediastore/a;->a:I

    new-instance v2, Lchat/ola/vn/m/x$5;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/x$5;-><init>(Lchat/ola/vn/m/x;)V

    iput-object v2, v0, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    iput-boolean v3, v0, Lchat/ola/vn/mediastore/a;->e:Z

    const v2, 0x7f0f0628

    invoke-virtual {p1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/m/x;->c:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/m/x;->c:Ljava/util/ArrayList;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_1
    return-object v1
.end method

.method public a(Lchat/ola/vn/entity/t;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/c;->a(Lchat/ola/vn/entity/t;)V

    iget-object v0, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/aj;->a(Lchat/ola/vn/entity/t;)V

    iget-object p1, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    invoke-virtual {p1}, Lchat/ola/vn/b/aj;->notifyDataSetChanged()V

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->d()V

    :cond_0
    return-void
.end method

.method public a_(I)V
    .locals 3

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/m/x;->i:Z

    new-instance p1, Lchat/ola/vn/m/x$2;

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    iget-object v1, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->j()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p1, p0, v0, v1}, Lchat/ola/vn/m/x$2;-><init>(Lchat/ola/vn/m/x;Lchat/ola/vn/entity/t;Ljava/lang/String;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->j()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p1

    invoke-virtual {v0, v1, v2, p1}, Lchat/ola/vn/network/OlaNetworkService;->k(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 1

    new-instance p1, Lchat/ola/vn/b/aj;

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/aj;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    iget-object p1, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/aj;->a(Lchat/ola/vn/b/j$a;)V

    iget-object p1, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/aj;->a(Lchat/ola/vn/entity/t;)V

    iget-object p1, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    iget-object v0, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->d()V

    return-void
.end method

.method public c()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    iget-object v1, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/t;->a(Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/x;->e:Lchat/ola/vn/b/aj;

    invoke-virtual {v0}, Lchat/ola/vn/b/aj;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    iget-object v1, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/t;->b(Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public g_()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->w()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-direct {p0, v1, v0}, Lchat/ola/vn/m/x;->a(Lchat/ola/vn/entity/t;Ljava/lang/String;)V

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public h_()Landroid/app/Dialog;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/x;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f040c

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/x;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0623

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/x;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/x$3;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/m/x$3;-><init>(Lchat/ola/vn/m/x;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1

    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public i()Z
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    return v0

    :cond_1
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3

    const/4 p3, 0x0

    const v0, 0x7f0b0116

    invoke-virtual {p1, v0, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    const v0, 0x7f090315

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaListView;

    iput-object v0, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    const v0, 0x7f0904ae

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/m/x;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/m/x;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v1, v1, [I

    const v2, 0x7f06003d

    aput v2, v1, p3

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object v0, p0, Lchat/ola/vn/m/x;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, p0}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    const v0, 0x7f0903ec

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/x;->f:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    new-instance v1, Lchat/ola/vn/m/x$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/x$1;-><init>(Lchat/ola/vn/m/x;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    iget-object v0, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, p3, p3}, Lchat/ola/vn/view/OlaListView;->setSelectionFromTop(II)V

    iget-object p3, p0, Lchat/ola/vn/m/x;->d:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/x;->a(Landroid/view/LayoutInflater;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p3, p1}, Lchat/ola/vn/view/OlaListView;->addHeaderView(Landroid/view/View;)V

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
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->f()Lchat/ola/vn/m/j;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p3, p1}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onRefresh()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/x;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    invoke-direct {p0}, Lchat/ola/vn/m/x;->j()V

    invoke-virtual {p0}, Lchat/ola/vn/m/x;->f()Lchat/ola/vn/m/j;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/x;->b:Lchat/ola/vn/entity/t;

    new-instance v2, Lchat/ola/vn/m/x$7;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/x$7;-><init>(Lchat/ola/vn/m/x;)V

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
