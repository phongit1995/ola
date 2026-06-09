.class public Lchat/ola/vn/message/OlaOtherPeopleListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/message/n;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->e:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->f:Lchat/ola/vn/message/n;

    return-void
.end method

.method private B()V
    .locals 2

    const v0, 0x7f0905fb

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->e:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->e:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance v0, Lchat/ola/vn/message/n;

    invoke-direct {v0, p0}, Lchat/ola/vn/message/n;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->f:Lchat/ola/vn/message/n;

    iget-object v0, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->f:Lchat/ola/vn/message/n;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f042c

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f04a9

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f0594

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/message/OlaOtherPeopleListActivity;

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


# virtual methods
.method protected a()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->f:Lchat/ola/vn/message/n;

    invoke-virtual {v0}, Lchat/ola/vn/message/n;->notifyDataSetChanged()V
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
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_2

    const v0, 0x7f09039e

    if-eq p1, v0, :cond_1

    const v0, 0x7f0903a3

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->e:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :cond_1
    const v2, 0x7f0f009b

    const v3, 0x7f0f04ab

    const v4, 0x7f0f04a6

    const v5, 0x7f0f0577

    new-instance v6, Lchat/ola/vn/message/OlaOtherPeopleListActivity$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity$1;-><init>(Lchat/ola/vn/message/OlaOtherPeopleListActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0160

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->B()V

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
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p3, 0x5

    if-ne p2, p3, :cond_0

    :try_start_1
    move-object p2, p1

    check-cast p2, Lchat/ola/vn/message/u;

    invoke-virtual {p2, p0}, Lchat/ola/vn/message/u;->a(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_3

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :cond_0
    :try_start_2
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x6

    if-ne p2, p3, :cond_1

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x7

    if-ne p2, p3, :cond_2

    invoke-static {p0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_2
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, p2, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_3
    return-void
.end method
