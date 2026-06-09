.class public Lchat/ola/vn/me/OlaMeCommentActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/r/a/d;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/b/v;

.field private g:Landroid/view/View;

.field private h:Landroid/view/View;

.field private i:Ljava/lang/String;

.field private j:Z

.field private k:Z

.field private l:Z

.field private o:Landroid/widget/TextView;

.field private p:J

.field private q:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private r:Z

.field private s:Landroid/widget/FrameLayout;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->i:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->j:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->k:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->r:Z

    return-void
.end method

.method private F()V
    .locals 2

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->r:Z

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->r:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->r:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->q:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method private G()V
    .locals 2

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->r:Z

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->r:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->r:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->q:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaMeCommentActivity;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->p:J

    return-wide v0
.end method

.method private a(JJ)V
    .locals 8

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    const-wide/16 v0, 0x0

    cmp-long v2, p3, v0

    if-eqz v2, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->n()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->g:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v7, 0x6

    move-wide v3, p1

    move-wide v5, p3

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(JJS)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    :cond_1
    return-void
.end method

.method public static a(Landroid/content/Context;J)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaMeCommentActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "_me_id"

    invoke-virtual {v0, v1, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaMeCommentActivity;JJ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/me/OlaMeCommentActivity;->b(JJ)V

    return-void
.end method

.method private b(JJ)V
    .locals 8

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    const-wide/16 v0, 0x0

    cmp-long v2, p3, v0

    if-eqz v2, :cond_0

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->n()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeCommentActivity;->F()V

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v7, 0x6

    move-wide v3, p1

    move-wide v5, p3

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(JJS)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    :cond_1
    return-void
.end method


# virtual methods
.method public B()V
    .locals 4

    const v0, 0x7f09060f

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeCommentActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->s:Landroid/widget/FrameLayout;

    const v0, 0x7f090309

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeCommentActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->e:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->e:Landroid/widget/ListView;

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    const v0, 0x7f0904ae

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeCommentActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->q:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->q:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v1, v1, [I

    const v3, 0x7f06003d

    aput v3, v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->q:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lchat/ola/vn/me/OlaMeCommentActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaMeCommentActivity$1;-><init>(Lchat/ola/vn/me/OlaMeCommentActivity;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeCommentActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->o:Landroid/widget/TextView;

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b00d1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f090609

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    const v1, 0x7f0903e9

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeCommentActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->g:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->e:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeCommentActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public C()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->i:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "chat.ola.vn.activity.MeCommentActivity"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->i:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->i:Ljava/lang/String;

    return-object v0
.end method

.method public D()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    invoke-virtual {v0}, Lchat/ola/vn/b/v;->notifyDataSetChanged()V

    return-void
.end method

.method public E()V
    .locals 0

    return-void
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public a(II)V
    .locals 0

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    const/4 p2, 0x6

    if-ne p2, p5, :cond_1

    const/16 p2, 0x22

    const/16 p3, 0x8

    if-eq p1, p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    invoke-virtual {p1, p3}, Landroid/view/View;->setVisibility(I)V

    const p1, 0x7f0f019d

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I)V

    goto :goto_0

    :cond_0
    const p1, 0x7f0f019e

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->j:Z

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->g:Landroid/view/View;

    invoke-virtual {p1, p3}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    invoke-virtual {p1, p3}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    return-void
.end method

.method public a(Landroid/os/Bundle;)V
    .locals 5

    new-instance p1, Lchat/ola/vn/b/v;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/v;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    new-instance v0, Lchat/ola/vn/me/OlaMeCommentActivity$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaMeCommentActivity$2;-><init>(Lchat/ola/vn/me/OlaMeCommentActivity;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/v;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    new-instance v0, Lchat/ola/vn/me/OlaMeCommentActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaMeCommentActivity$3;-><init>(Lchat/ola/vn/me/OlaMeCommentActivity;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/v;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->e:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->e:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeCommentActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeCommentActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "_me_id"

    const-wide/16 v1, 0x0

    invoke-virtual {p1, v0, v1, v2}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v3

    iput-wide v3, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->p:J

    iget-wide v3, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->p:J

    cmp-long p1, v3, v1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->g:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->n()V

    iget-wide v3, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->p:J

    invoke-direct {p0, v3, v4, v1, v2}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(JJ)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeCommentActivity;->finish()V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    const p2, 0x7f0f0489

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->g()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->o:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->g()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->o:Landroid/widget/TextView;

    const v0, 0x7f0f0488

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->o:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->g()I

    move-result p1

    int-to-long v1, p1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->append(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->o:Landroid/widget/TextView;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->o:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    :cond_2
    :goto_1
    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    invoke-virtual {p1}, Lchat/ola/vn/b/v;->notifyDataSetChanged()V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;S)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;S)V"
        }
    .end annotation

    const/4 p3, 0x0

    if-eqz p2, :cond_0

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iput-boolean p3, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->j:Z

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->g:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entity/g;Ljava/util/List;)V

    iput-boolean p3, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeCommentActivity;->G()V

    return-void
.end method

.method public a(Lchat/ola/vn/entry/a;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/a;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Lchat/ola/vn/entry/b;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/b;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/util/List;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(Lchat/ola/vn/entry/b;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/b;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    invoke-virtual {p1}, Lchat/ola/vn/b/v;->notifyDataSetChanged()V

    return-void
.end method

.method public b(Ljava/util/List;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    invoke-virtual {p1}, Lchat/ola/vn/b/v;->notifyDataSetChanged()V

    return-void
.end method

.method public d(I)V
    .locals 0

    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public e(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public f(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaMeCommentActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public j()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->f:Lchat/ola/vn/b/v;

    invoke-virtual {v0}, Lchat/ola/vn/b/v;->notifyDataSetChanged()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeCommentActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const v0, 0x7f0b00e6

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeCommentActivity;->setContentView(I)V

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeCommentActivity;->B()V

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/os/Bundle;)V

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, p0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/d;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->n()V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p0}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/r/a/d;)V

    return-void
.end method

.method protected onPause()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    const/16 p1, 0xa

    if-ge p4, p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->h:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    add-int/2addr p2, p3

    if-lez p4, :cond_1

    add-int/lit8 p1, p4, -0x5

    if-lt p2, p1, :cond_1

    if-eq p3, p4, :cond_1

    iget-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->j:Z

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->k:Z

    :cond_1
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 5

    if-eqz p2, :cond_0

    return-void

    :cond_0
    iget-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->k:Z

    if-eqz p1, :cond_2

    iget-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->l:Z

    if-nez p1, :cond_1

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->p()J

    move-result-wide p1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->o()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    cmp-long v4, p1, v2

    if-eqz v4, :cond_1

    invoke-direct {p0, v0, v1, p1, p2}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(JJ)V

    :cond_1
    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->k:Z

    :cond_2
    return-void
.end method

.method public z()Landroid/widget/FrameLayout;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;->s:Landroid/widget/FrameLayout;

    return-object v0
.end method
