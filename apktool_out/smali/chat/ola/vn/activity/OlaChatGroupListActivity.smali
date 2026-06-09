.class public Lchat/ola/vn/activity/OlaChatGroupListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;


# instance fields
.field private e:Landroid/view/View;

.field private f:Landroid/widget/ListView;

.field private g:Lchat/ola/vn/b/m;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->e:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->g:Lchat/ola/vn/b/m;

    return-void
.end method

.method private B()V
    .locals 1

    const v0, 0x7f090154

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    const v0, 0x7f09002d

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->e:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    const v0, 0x7f09002c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090088

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private C()V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/b/m;

    invoke-direct {v0}, Lchat/ola/vn/b/m;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->g:Lchat/ola/vn/b/m;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->g:Lchat/ola/vn/b/m;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatGroupListActivity;)Lchat/ola/vn/b/m;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->g:Lchat/ola/vn/b/m;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaChatGroupListActivity;

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

.method private a(Landroid/content/Context;Lchat/ola/vn/message/f;)V
    .locals 11

    const-string v0, ""

    :try_start_0
    invoke-virtual {p2}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, v1

    goto :goto_0

    :catch_0
    move-object v3, v0

    :goto_0
    const/4 v4, 0x0

    const v5, 0x7f0f01a7

    const v6, 0x7f0f00b7

    const v7, 0x7f0f0585

    const v8, 0x7f0f044d

    const/4 v9, 0x0

    new-instance v10, Lchat/ola/vn/activity/OlaChatGroupListActivity$2;

    invoke-direct {v10, p0, p2}, Lchat/ola/vn/activity/OlaChatGroupListActivity$2;-><init>(Lchat/ola/vn/activity/OlaChatGroupListActivity;Lchat/ola/vn/message/f;)V

    move-object v2, p1

    invoke-static/range {v2 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/p;

    move-result-object p1

    const/16 p2, 0x2000

    invoke-virtual {p1, p2}, Lchat/ola/vn/i/p;->b(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatGroupListActivity;Landroid/content/Context;Lchat/ola/vn/message/f;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->a(Landroid/content/Context;Lchat/ola/vn/message/f;)V

    return-void
.end method


# virtual methods
.method protected a()V
    .locals 3

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->E()I

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    invoke-virtual {v0, v2}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->e:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->f:Landroid/widget/ListView;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatGroupListActivity;->e:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->overridePendingTransition(II)V
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

    const v0, 0x7f09002c

    if-eq p1, v0, :cond_1

    const v0, 0x7f090088

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0147

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->B()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->C()V

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
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p3}, Lchat/ola/vn/message/g;->d(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p2

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    invoke-static {p2, p3, p4, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p3}, Lchat/ola/vn/message/g;->d(I)Lchat/ola/vn/message/f;

    move-result-object p1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    const p3, 0x7f0f0453

    invoke-virtual {p0, p3}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p3, 0x7f0f04a6

    invoke-virtual {p0, p3}, Lchat/ola/vn/activity/OlaChatGroupListActivity;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance p3, Lchat/ola/vn/i/m;

    invoke-direct {p3, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p4

    invoke-virtual {p3, p4}, Lchat/ola/vn/i/m;->setTitle(Ljava/lang/CharSequence;)V

    invoke-virtual {p3, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p4, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;

    invoke-direct {p4, p0, p2, p1}, Lchat/ola/vn/activity/OlaChatGroupListActivity$1;-><init>(Lchat/ola/vn/activity/OlaChatGroupListActivity;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {p3, p4}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p3}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method
