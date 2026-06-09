.class public Lchat/ola/vn/me/OlaPeopleListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Lchat/ola/vn/f/a;


# instance fields
.field protected e:Ljava/lang/String;

.field private f:Landroid/widget/ListView;

.field private g:Lchat/ola/vn/b/ac;

.field private h:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private i:Ljava/lang/String;

.field private j:Landroid/view/View;

.field private k:Landroid/view/View;

.field private l:Z

.field private o:Landroid/widget/TextView;

.field private p:Z

.field private q:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 6

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaPeopleListActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "_title"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "_buddy_id"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->i:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    const-string v1, "_action"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->q:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->q:Ljava/lang/String;

    if-eqz v1, :cond_2

    const-string v1, "android.intent.action.VIEW"

    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->q:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->i:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/me/OlaPeopleListActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_2
    :goto_0
    const-string v1, "_buddy_ids"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringArrayExtra(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v1, :cond_4

    aget-object v4, v0, v3

    sget-object v5, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v5, v4, v2}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v5

    if-nez v5, :cond_3

    new-instance v5, Lchat/ola/vn/message/f;

    invoke-direct {v5, v4, v2}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    :cond_3
    iget-object v4, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

    iget-object v1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

    invoke-virtual {v0}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_6
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaPeopleListActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "_action"

    const-string v2, "ACTION_VIEW_FAN_LIST"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "_title"

    const v2, 0x7f0f04ed

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "_buddy_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaPeopleListActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->k:Landroid/view/View;

    return-object p0
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 3

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "_action"

    const-string v2, "ACTION_VIEW_FRIEND_LIST"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "_title"

    const v2, 0x7f0f04f9

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "_buddy_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->l:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    :cond_0
    const/16 v0, 0x8

    const/4 v1, 0x0

    if-nez p2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->clear()V

    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->k:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->k:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    new-instance v0, Lchat/ola/vn/me/OlaPeopleListActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaPeopleListActivity$1;-><init>(Lchat/ola/vn/me/OlaPeopleListActivity;)V

    new-instance v1, Lchat/ola/vn/me/OlaPeopleListActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaPeopleListActivity$2;-><init>(Lchat/ola/vn/me/OlaPeopleListActivity;)V

    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->q:Ljava/lang/String;

    const-string v3, "ACTION_VIEW_FAN_LIST"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :cond_4
    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->q:Ljava/lang/String;

    const-string v3, "ACTION_VIEW_FRIEND_LIST"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->q:Ljava/lang/String;

    const-string v0, "ACTION_VIEW_SUGGESTED_FRIEND_LIST"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;S)V

    :cond_6
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;)V
    .locals 4

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->l:Z

    if-eqz p2, :cond_3

    iput-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->e:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    :cond_0
    array-length p1, p2

    const/4 v1, 0x0

    :goto_0
    if-ge v1, p1, :cond_2

    aget-object v2, p2, v1

    sget-object v3, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v3, v2, v0}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v3

    if-nez v3, :cond_1

    new-instance v3, Lchat/ola/vn/message/f;

    invoke-direct {v3, v2, v0}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

    iget-object p2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->h:Ljava/util/List;

    invoke-virtual {p1, p2}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

    invoke-virtual {p1}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->k:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :cond_3
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaPeopleListActivity;->overridePendingTransition(II)V
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
    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->f:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaPeopleListActivity;->finish()V

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
    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->setContentView(I)V

    const p1, 0x7f0903e9

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->j:Landroid/view/View;

    const p1, 0x7f0903a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->o:Landroid/widget/TextView;

    const p1, 0x7f09039c

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903a4

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    const v0, 0x7f0b00d1

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->k:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->k:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    const p1, 0x7f09031d

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ListView;

    iput-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->f:Landroid/widget/ListView;

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->f:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->k:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->f:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    add-int/2addr p2, p3

    add-int/lit8 p1, p4, -0x5

    if-lt p2, p1, :cond_0

    if-eq p3, p4, :cond_0

    iget-boolean p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->l:Z

    if-nez p1, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->p:Z

    :cond_0
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    if-nez p2, :cond_1

    iget-boolean p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->p:Z

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->i:Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->e:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/me/OlaPeopleListActivity;->f(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->p:Z

    :cond_1
    return-void
.end method

.method protected onStart()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->onStart()V

    new-instance v0, Lchat/ola/vn/b/ac;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/ac;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/ac;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->f:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaPeopleListActivity;->g:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaPeopleListActivity;->B()V

    return-void
.end method
