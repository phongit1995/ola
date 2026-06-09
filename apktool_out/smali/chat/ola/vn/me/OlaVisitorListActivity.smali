.class public Lchat/ola/vn/me/OlaVisitorListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/me/OlaVisitorListActivity$a;
    }
.end annotation


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/me/d;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private h:Ljava/lang/String;

.field private i:Z

.field private j:Landroid/view/View;

.field private k:Landroid/view/View;

.field private l:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private m:Z

.field private n:Z

.field private o:Lchat/ola/vn/p/k;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->e:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->g:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->h:Ljava/lang/String;

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->i:Z

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->j:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->k:Landroid/view/View;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->m:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->n:Z

    return-void
.end method

.method private C()V
    .locals 4

    const v0, 0x7f0905fb

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f090088

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09000f

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->k:Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b00d1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->j:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->j:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->j:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    const v0, 0x7f0905fc

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaVisitorListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->l:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->l:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v1, v1, [I

    const/4 v2, 0x0

    const v3, 0x7f06003d

    aput v3, v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->l:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lchat/ola/vn/me/OlaVisitorListActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaVisitorListActivity$1;-><init>(Lchat/ola/vn/me/OlaVisitorListActivity;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    return-void
.end method

.method private D()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/me/d;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/d;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    invoke-virtual {v0, p0}, Lchat/ola/vn/me/d;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    invoke-virtual {v0, p0}, Lchat/ola/vn/me/d;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->i:Z

    goto :goto_0

    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->i:Z

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->o:Lchat/ola/vn/p/k;

    if-nez v0, :cond_2

    new-instance v0, Lchat/ola/vn/me/OlaVisitorListActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaVisitorListActivity$2;-><init>(Lchat/ola/vn/me/OlaVisitorListActivity;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->o:Lchat/ola/vn/p/k;

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->g:Ljava/util/List;

    if-nez v0, :cond_3

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a_(I)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    iget-object v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->g:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/me/d;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    invoke-virtual {v0}, Lchat/ola/vn/me/d;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private E()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->m:Z

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {p0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->l:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v1, v0}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method

.method private F()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->m:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->l:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->m:Z

    return-void
.end method

.method private G()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->m:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->l:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->m:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->h:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaVisitorListActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->h:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaVisitorListActivity;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->g:Ljava/util/List;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaVisitorListActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x20000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->i:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaVisitorListActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->g:Ljava/util/List;

    return-object p0
.end method

.method static synthetic b(Landroid/content/Context;)V
    .locals 0

    invoke-static {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->c(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaVisitorListActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->n:Z

    return p1
.end method

.method static synthetic c(Lchat/ola/vn/me/OlaVisitorListActivity;)Lchat/ola/vn/me/d;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    return-object p0
.end method

.method private static c(Landroid/content/Context;)V
    .locals 0

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/me/OlaVisitorListActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->k:Landroid/view/View;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/me/OlaVisitorListActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->E()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/me/OlaVisitorListActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->j:Landroid/view/View;

    return-object p0
.end method

.method static synthetic g(Lchat/ola/vn/me/OlaVisitorListActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->G()V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/me/OlaVisitorListActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->F()V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->i:Z

    return v0
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->D()V

    return-void
.end method

.method public a_(I)V
    .locals 3

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->n:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->k:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->j:Landroid/view/View;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->k:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->j:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->n:Z

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->h:Ljava/lang/String;

    const/16 v1, 0x28

    iget-object v2, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->o:Lchat/ola/vn/p/k;

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ILchat/ola/vn/p/k;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaVisitorListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f09000f

    if-eq v0, v1, :cond_4

    const v1, 0x7f090031

    if-eq v0, v1, :cond_2

    const v1, 0x7f090088

    if-eq v0, v1, :cond_1

    const v1, 0x7f0905fa

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    new-instance v1, Lchat/ola/vn/me/OlaVisitorListActivity$a;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lchat/ola/vn/me/OlaVisitorListActivity$a;-><init>(Lchat/ola/vn/me/OlaVisitorListActivity;Lchat/ola/vn/me/OlaVisitorListActivity$1;)V

    invoke-static {p0, v0, p1, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->finish()V

    return-void

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_3

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/message/f;)V

    goto :goto_0

    :cond_3
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->e(Ljava/lang/String;)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->d(Lchat/ola/vn/message/f;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->f:Lchat/ola/vn/me/d;

    invoke-virtual {p1}, Lchat/ola/vn/me/d;->notifyDataSetChanged()V

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/me/OlaVisitorListActivity;->e:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0181

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaVisitorListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaVisitorListActivity;->C()V

    return-void
.end method
