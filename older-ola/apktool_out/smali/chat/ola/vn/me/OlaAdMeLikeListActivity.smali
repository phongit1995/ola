.class public Lchat/ola/vn/me/OlaAdMeLikeListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/f/a;


# instance fields
.field protected e:Ljava/lang/String;

.field protected f:Ljava/lang/String;

.field private g:Landroid/widget/ListView;

.field private h:Lchat/ola/vn/b/ac;

.field private i:Landroid/view/View;

.field private j:Landroid/view/View;

.field private k:Landroid/widget/TextView;

.field private l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private o:I

.field private p:Ljava/lang/String;

.field private q:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->i:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "_adme_id"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->p:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "me_like_count"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->o:I

    iget v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->o:I

    const/4 v2, 0x1

    const v3, 0x7f0f0537

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->k:Landroid/widget/TextView;

    new-array v2, v2, [Ljava/lang/Object;

    iget v4, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->o:I

    int-to-long v4, v4

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v1

    :goto_0
    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->k:Landroid/widget/TextView;

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, ""

    aput-object v4, v2, v1

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->p:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->p:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->i:Landroid/view/View;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaAdMeLikeListActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "_adme_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "me_like_count"

    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->j:Landroid/view/View;

    return-object p0
.end method

.method private f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    if-nez p2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f:Ljava/lang/String;

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f:Ljava/lang/String;

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    iput-object p2, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->q:Z

    const/4 v0, 0x0

    const/16 v1, 0x8

    if-nez p2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->l:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->clear()V

    iget-object v2, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->j:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->i:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    invoke-virtual {v0}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->j:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->i:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaAdMeLikeListActivity$1;-><init>(Lchat/ola/vn/me/OlaAdMeLikeListActivity;)V

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    invoke-virtual {v0, p1, p2, v1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;)V
    .locals 5

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->q:Z

    if-eqz p2, :cond_1

    array-length v1, p2

    if-lez v1, :cond_1

    array-length v1, p2

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, p2, v2

    sget-object v4, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v4, v3, v0}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v4

    if-nez v4, :cond_0

    new-instance v4, Lchat/ola/vn/message/f;

    invoke-direct {v4, v3, v0}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->l:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->l:Ljava/util/List;

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    iget-object p2, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    invoke-virtual {p2}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V

    iput-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->i:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->j:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090031

    if-eq v0, v1, :cond_3

    const v1, 0x7f09039c

    if-eq v0, v1, :cond_2

    const v1, 0x7f0903a4

    if-eq v0, v1, :cond_1

    const v1, 0x7f0904a6

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    invoke-static {p0, v0, p1, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->g:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->finish()V

    return-void

    :cond_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_4

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/message/f;)V

    goto :goto_0

    :cond_4
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->e(Ljava/lang/String;)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->d(Lchat/ola/vn/message/f;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    invoke-virtual {p1}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b00ac

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->setContentView(I)V

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903a4

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903e9

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->i:Landroid/view/View;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->k:Landroid/widget/TextView;

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    const v0, 0x7f0b00d1

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->j:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->j:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    const p1, 0x7f09031d

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ListView;

    iput-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->g:Landroid/widget/ListView;

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->g:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setVerticalScrollBarEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->g:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->j:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->g:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    return-void
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
    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/ac;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p2, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    add-int/2addr p2, p3

    add-int/lit8 p1, p4, -0x5

    if-lt p2, p1, :cond_0

    if-eq p3, p4, :cond_0

    :try_start_0
    iget-boolean p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->q:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    invoke-virtual {p1}, Lchat/ola/vn/b/ac;->getCount()I

    move-result p1

    if-lez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->p:Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->e:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->f(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    return-void
.end method

.method protected onStart()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->onStart()V

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->g:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    new-instance v0, Lchat/ola/vn/b/ac;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/ac;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/ac;->a(Landroid/view/View$OnClickListener;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->l:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    iget-object v1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->l:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->g:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->h:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaAdMeLikeListActivity;->B()V

    return-void
.end method
