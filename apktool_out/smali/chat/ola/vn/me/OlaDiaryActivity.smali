.class public Lchat/ola/vn/me/OlaDiaryActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/b/u;

.field private g:Z

.field private h:Z

.field private i:Z

.field private j:Landroid/view/View;

.field private k:Landroid/view/View;

.field private l:Lchat/ola/vn/r/a/e;

.field private m:J

.field private n:Landroid/support/v4/widget/SwipeRefreshLayout;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->e:Landroid/widget/ListView;

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->g:Z

    const/4 v1, 0x0

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->h:Z

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->i:Z

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->k:Landroid/view/View;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->m:J

    return-void
.end method

.method private C()V
    .locals 4

    const v0, 0x7f0901e6

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f06cc

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f042c

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090612

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->k:Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b00d1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->e:Landroid/widget/ListView;

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    const v0, 0x7f0901e7

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->n:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->n:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v1, v1, [I

    const v3, 0x7f06003d

    aput v3, v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->n:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lchat/ola/vn/me/OlaDiaryActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaDiaryActivity$1;-><init>(Lchat/ola/vn/me/OlaDiaryActivity;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    return-void
.end method

.method private D()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->i:Z

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {p0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->n:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v1, v0}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method

.method private E()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->i:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iput-boolean v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->i:Z

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->n:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method

.method private F()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->i:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iput-boolean v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->i:Z

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->n:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method

.method private G()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/r/a/e;

    invoke-direct {v0}, Lchat/ola/vn/r/a/e;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->l:Lchat/ola/vn/r/a/e;

    new-instance v0, Lchat/ola/vn/b/u;

    iget-object v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->l:Lchat/ola/vn/r/a/e;

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/b/u;-><init>(Landroid/content/Context;Lchat/ola/vn/r/a/e;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/u;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    new-instance v1, Lchat/ola/vn/me/OlaDiaryActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaDiaryActivity$2;-><init>(Lchat/ola/vn/me/OlaDiaryActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    new-instance v1, Lchat/ola/vn/me/OlaDiaryActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaDiaryActivity$3;-><init>(Lchat/ola/vn/me/OlaDiaryActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->d(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method private a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V
    .locals 0

    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    :try_start_0
    invoke-virtual {p4}, Lchat/ola/vn/entry/b;->f()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result p2

    const/4 p3, 0x1

    if-ne p2, p3, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p3}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object p3

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_0

    new-instance p2, Lchat/ola/vn/d/b;

    invoke-direct {p2, p4}, Lchat/ola/vn/d/b;-><init>(Lchat/ola/vn/entry/b;)V

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p2

    invoke-virtual {p3, p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->n(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V
    .locals 9

    invoke-virtual {p2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v6

    if-nez v6, :cond_0

    return-void

    :cond_0
    iget-object v4, p2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f0491

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f0493

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f04ae

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v7, Lchat/ola/vn/i/m;

    invoke-direct {v7, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v7, v2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v8, Lchat/ola/vn/me/OlaDiaryActivity$5;

    move-object v0, v8

    move-object v1, p0

    move-object v3, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/me/OlaDiaryActivity$5;-><init>(Lchat/ola/vn/me/OlaDiaryActivity;Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/g;Lchat/ola/vn/entry/b;Ljava/lang/String;)V

    invoke-virtual {v7, v8}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v7}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private a(Landroid/view/View;)V
    .locals 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    sparse-switch v0, :sswitch_data_0

    return-void

    :goto_0
    :sswitch_0
    invoke-static {p0}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;)V

    return-void

    :sswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    const/4 v1, 0x4

    :goto_1
    invoke-direct {p0, p0, p1, v1, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p0, p1, v2, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    const/4 v1, 0x2

    goto :goto_1

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p0, p1, v3, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_5
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p0, p1, v4, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V

    return-void

    :sswitch_6
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    :goto_2
    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, v0, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_7
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_10

    iget-byte v1, v0, Lchat/ola/vn/entry/b;->l:B

    packed-switch v1, :pswitch_data_0

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    goto :goto_4

    :pswitch_0
    iget-object p1, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    :goto_3
    invoke-static {p0, p1}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :pswitch_1
    iget-object p1, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :goto_4
    invoke-static {p0, v0, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;)V

    return-void

    :sswitch_8
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    if-eqz v1, :cond_10

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_10

    iget-object v1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ne v1, v3, :cond_3

    iget-object p1, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {p1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    goto :goto_3

    :cond_3
    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    :goto_5
    invoke-direct {p0, p1, v0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/view/View;Ljava/util/List;)V

    return-void

    :sswitch_9
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_4

    return-void

    :cond_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    if-eqz v1, :cond_10

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_10

    iget-object v1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ne v1, v3, :cond_5

    iget-object p1, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {p1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/util/b;->f(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_5
    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    goto :goto_5

    :sswitch_a
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_6

    return-void

    :cond_6
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_10

    invoke-static {v0}, Lchat/ola/vn/c/f;->c(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c/f;->b()Ljava/lang/String;

    move-result-object v0

    new-array v5, v3, [Ljava/lang/String;

    aput-object v0, v5, v4

    invoke-static {v2, v3, v4, v5}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(ISZ[Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {p0, p1, v1, v4, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :sswitch_b
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_7

    return-void

    :cond_7
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    invoke-direct {p0, p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;Lchat/ola/vn/entry/b;)V

    return-void

    :sswitch_c
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_8

    return-void

    :cond_8
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/f;

    iget-object v0, p1, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-static {p0, v0}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V

    iget-object v0, p1, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v0

    const-string v2, "rss"

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_10

    iget-object v0, p1, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_9

    iget-object p1, p1, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->c()Ljava/lang/String;

    move-result-object v0

    :cond_9
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_10

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, v0, v1, v4}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :sswitch_d
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_a

    return-void

    :cond_a
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->A()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_b

    goto/16 :goto_0

    :cond_b
    iget-object v0, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-boolean v0, v0, Lchat/ola/vn/entity/g;->c:Z

    if-eqz v0, :cond_10

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    invoke-static {p0, v0, v1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;J)V

    return-void

    :sswitch_e
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_c

    return-void

    :cond_c
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object v0, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    if-nez v0, :cond_d

    :try_start_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v1

    const-string v2, "viewme"

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    goto/16 :goto_2

    :cond_d
    iget-object v0, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_4

    :try_start_3
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :try_start_4
    invoke-static {p0, v0}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V

    return-void

    :sswitch_f
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v1

    if-eqz v1, :cond_f

    invoke-virtual {v1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    if-eqz v2, :cond_e

    goto :goto_6

    :cond_e
    :try_start_5
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    :catch_2
    :try_start_6
    invoke-static {p0, v1}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;Lchat/ola/vn/entity/d;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_4

    return-void

    :cond_f
    :goto_6
    :try_start_7
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v3, v1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    :try_start_8
    invoke-static {p0, p1, v4, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4

    :catch_4
    :cond_10
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090045 -> :sswitch_f
        0x7f090047 -> :sswitch_e
        0x7f090056 -> :sswitch_d
        0x7f090079 -> :sswitch_c
        0x7f0900f4 -> :sswitch_b
        0x7f09028e -> :sswitch_a
        0x7f090292 -> :sswitch_9
        0x7f090293 -> :sswitch_8
        0x7f090295 -> :sswitch_7
        0x7f090307 -> :sswitch_7
        0x7f09033a -> :sswitch_6
        0x7f090348 -> :sswitch_5
        0x7f090349 -> :sswitch_4
        0x7f09034a -> :sswitch_3
        0x7f09034b -> :sswitch_2
        0x7f09034c -> :sswitch_1
        0x7f0904eb -> :sswitch_0
        0x7f090550 -> :sswitch_6
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private a(Landroid/view/View;Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    new-instance v0, Lcom/mg/ola/common/c/b;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/c/b;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/c/b;->a(Z)V

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v2

    packed-switch v2, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    new-instance v2, Lcom/mg/ola/common/c/a;

    const v3, 0x7f080717

    const-string v4, ""

    invoke-direct {v2, p0, v3, v4}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_1
    new-instance v2, Lcom/mg/ola/common/c/a;

    const v3, 0x7f08071a

    const-string v4, ""

    invoke-direct {v2, p0, v3, v4}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    goto :goto_1

    :pswitch_2
    new-instance v2, Lcom/mg/ola/common/c/a;

    const v3, 0x7f080714

    const-string v4, ""

    invoke-direct {v2, p0, v3, v4}, Lcom/mg/ola/common/c/a;-><init>(Landroid/content/Context;ILjava/lang/CharSequence;)V

    :goto_1
    invoke-virtual {v0, v2}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/a;)V

    goto :goto_0

    :cond_0
    new-instance v1, Lchat/ola/vn/me/OlaDiaryActivity$4;

    invoke-direct {v1, p0, p2}, Lchat/ola/vn/me/OlaDiaryActivity$4;-><init>(Lchat/ola/vn/me/OlaDiaryActivity;Ljava/util/List;)V

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/c$a;)V

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/c/b;->a(Landroid/view/View;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaDiaryActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->D()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaDiaryActivity;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/view/View;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaDiaryActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->g:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaDiaryActivity;)Lchat/ola/vn/r/a/e;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->l:Lchat/ola/vn/r/a/e;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaDiaryActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->d(Z)V

    return-void
.end method

.method private b(Landroid/view/View;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaDiaryActivity;Landroid/view/View;)Z
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->b(Landroid/view/View;)Z

    move-result p0

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/me/OlaDiaryActivity;)Lchat/ola/vn/b/u;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/me/OlaDiaryActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->c(Z)V

    return-void
.end method

.method private c(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->k:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->k:Landroid/view/View;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method private d(Z)V
    .locals 4

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->h:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->l:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->l()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    if-eqz p1, :cond_1

    move-wide v0, v2

    :cond_1
    cmp-long p1, v0, v2

    const/4 v2, 0x1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    const/4 v3, 0x0

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v3}, Lchat/ola/vn/me/OlaDiaryActivity;->c(Z)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    const/4 v3, 0x4

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaDiaryActivity;->c(Z)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->l:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, v2}, Lchat/ola/vn/r/a/e;->a(Z)V

    iput-boolean v2, p0, Lchat/ola/vn/me/OlaDiaryActivity;->h:Z

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/16 v2, 0x4e

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(JS)V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->g:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->G()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    const/16 p1, 0x4e

    if-ne p5, p1, :cond_0

    const/4 p1, 0x0

    :try_start_0
    iput-boolean p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->h:Z

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->g:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->c(Z)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->F()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V
    .locals 6

    const/4 p1, 0x0

    :try_start_0
    iput-boolean p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->h:Z

    const/4 p2, 0x1

    iput-boolean p2, p0, Lchat/ola/vn/me/OlaDiaryActivity;->g:Z

    if-eqz p3, :cond_1

    array-length p2, p3

    if-lez p2, :cond_1

    iget-wide v0, p0, Lchat/ola/vn/me/OlaDiaryActivity;->m:J

    const-wide/16 v2, 0x0

    cmp-long p2, v0, v2

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity;->l:Lchat/ola/vn/r/a/e;

    const-string p4, "my diary"

    invoke-static {p3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p3

    invoke-virtual {p2, p4, p1, p3}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;SLjava/util/List;)V

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity;->l:Lchat/ola/vn/r/a/e;

    invoke-static {p3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p3

    invoke-virtual {p2, p3}, Lchat/ola/vn/r/a/e;->c(Ljava/util/List;)V

    goto :goto_0

    :cond_1
    iput-boolean p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->g:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const v1, 0x7f0f00a2

    const v2, 0x7f0f0233

    const v3, 0x7f0f06bf

    const v4, 0x7f0f0480

    :try_start_1
    new-instance v5, Lchat/ola/vn/me/OlaDiaryActivity$6;

    invoke-direct {v5, p0}, Lchat/ola/vn/me/OlaDiaryActivity$6;-><init>(Lchat/ola/vn/me/OlaDiaryActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :goto_0
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->E()V

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->j:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->f:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    const p1, 0x7f0f009f

    const p2, 0x7f0f024e

    :try_start_3
    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    return-void
.end method

.method public a_(I)V
    .locals 0

    const/4 p1, 0x0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->d(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_2

    const v0, 0x7f0903a4

    if-eq p1, v0, :cond_1

    const v0, 0x7f090612

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-static {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Landroid/content/Context;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity;->e:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0151

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaDiaryActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->C()V

    return-void
.end method
