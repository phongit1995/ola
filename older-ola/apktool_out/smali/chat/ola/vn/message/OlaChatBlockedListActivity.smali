.class public Lchat/ola/vn/message/OlaChatBlockedListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/message/b;

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

.field private i:Landroid/view/View;

.field private j:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->e:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->h:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->j:Landroid/view/View;

    return-void
.end method

.method private C()V
    .locals 3

    const v0, 0x7f090090

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f043b

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f0668

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->j:Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b00d1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    return-void
.end method

.method private D()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/message/b;

    invoke-direct {v0, p0}, Lchat/ola/vn/message/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/b;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/b;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->e:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    if-nez v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->a_(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    iget-object v1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/b;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    invoke-virtual {v0}, Lchat/ola/vn/message/b;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/message/OlaChatBlockedListActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

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
.method public B()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->h:Ljava/lang/String;

    const-string v1, "null"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->D()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    const/16 p1, 0x4d

    if-ne p5, p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->j:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->h:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    const/4 p2, 0x4

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 3

    iput-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->h:Ljava/lang/String;

    iget-object p3, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->j:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p3, v0}, Landroid/view/View;->setVisibility(I)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    if-eqz p2, :cond_0

    array-length p1, p2

    if-nez p1, :cond_1

    :cond_0
    const-string p1, "null"

    iput-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->h:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    const/4 p3, 0x4

    invoke-virtual {p1, p3}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    if-eqz p2, :cond_5

    array-length p1, p2

    if-lez p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    if-nez p1, :cond_2

    new-instance p1, Ljava/util/ArrayList;

    const/16 p3, 0x3e8

    invoke-direct {p1, p3}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    iget-object p3, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    invoke-virtual {p1, p3}, Lchat/ola/vn/message/b;->a(Ljava/util/List;)V

    :cond_2
    array-length p1, p2

    const/4 p3, 0x0

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p1, :cond_4

    aget-object v1, p2, v0

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v2, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v2

    if-nez v2, :cond_3

    new-instance v2, Lchat/ola/vn/message/f;

    invoke-direct {v2, v1, p3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    invoke-virtual {p1}, Lchat/ola/vn/message/b;->notifyDataSetChanged()V

    :cond_5
    return-void
.end method

.method public a_(I)V
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->j:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->j:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->i:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->h:Ljava/lang/String;

    const/16 v1, 0x4d

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;S)V
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
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 8

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    const/4 v2, 0x0

    invoke-static {v0, v1, p1, v2}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V

    return-void

    :sswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->n(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->f:Lchat/ola/vn/message/b;

    invoke-virtual {v0}, Lchat/ola/vn/message/b;->notifyDataSetChanged()V

    const v0, 0x7f0f037b

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v2, v1

    invoke-virtual {p0, v0, v2}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_2
    iget-object p1, p0, Lchat/ola/vn/message/OlaChatBlockedListActivity;->e:Landroid/widget/ListView;

    invoke-virtual {p1, v1}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :sswitch_3
    const v3, 0x7f0f0668

    const v4, 0x7f0f0236

    const v5, 0x7f0f06c2

    const v6, 0x7f0f0577

    new-instance v7, Lchat/ola/vn/message/OlaChatBlockedListActivity$1;

    invoke-direct {v7, p0}, Lchat/ola/vn/message/OlaChatBlockedListActivity$1;-><init>(Lchat/ola/vn/message/OlaChatBlockedListActivity;)V

    move-object v2, p0

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :sswitch_4
    invoke-virtual {p0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f09039c -> :sswitch_4
        0x7f09039e -> :sswitch_3
        0x7f0903a4 -> :sswitch_2
        0x7f0905b8 -> :sswitch_1
        0x7f0905fa -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b013e

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->C()V

    return-void
.end method
