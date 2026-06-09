.class public Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$a;
    }
.end annotation


# instance fields
.field private e:Landroid/widget/ListView;

.field private f:Lchat/ola/vn/b/ac;

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

.field private j:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->e:Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->g:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->h:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->i:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->j:Z

    return-void
.end method

.method private C()V
    .locals 2

    const v0, 0x7f0904a9

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->e:Landroid/widget/ListView;

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f0556

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039a

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const v1, 0x7f080628

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private D()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    const/4 v1, 0x1

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/b/ac;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/ac;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ac;->a(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/ac;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/ac;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->e:Landroid/widget/ListView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    invoke-virtual {v0, v2}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->j:Z

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->y()Ljava/util/List;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->g:Ljava/util/List;

    goto :goto_1

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->x()Ljava/util/List;

    move-result-object v0

    goto :goto_0

    :goto_1
    sget-object v0, Lchat/ola/vn/r/a/e;->a:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->h:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->i:Z

    goto :goto_2

    :cond_2
    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->i:Z

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->g:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    invoke-virtual {v0}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->h:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->h:Ljava/lang/String;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Landroid/content/Context;Z)V

    return-void
.end method

.method public static a(Landroid/content/Context;Z)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x20000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const-string v1, "ignorePhoneFriend"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

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

.method static synthetic a(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->i:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->g:Ljava/util/List;

    return-object p0
.end method

.method static synthetic b(Landroid/content/Context;)V
    .locals 0

    invoke-static {p0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->c(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)Lchat/ola/vn/b/ac;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    return-object p0
.end method

.method private static c(Landroid/content/Context;)V
    .locals 0

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->i:Z

    return v0
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->D()V

    return-void
.end method

.method public a_(I)V
    .locals 2

    :try_start_0
    new-instance p1, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;-><init>(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->h:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p1

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;S)V
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
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->overridePendingTransition(II)V
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

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    new-instance v1, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$a;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$a;-><init>(Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;Lchat/ola/vn/activity/OlaSuggestedFriendListActivity$1;)V

    invoke-static {p0, v0, p1, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V

    return-void

    :sswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->e:Landroid/widget/ListView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->finish()V

    return-void

    :sswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;)V

    :goto_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->w(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->g:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/ac;->a(Ljava/util/List;)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->f:Lchat/ola/vn/b/ac;

    invoke-virtual {p1}, Lchat/ola/vn/b/ac;->notifyDataSetChanged()V

    return-void

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/message/f;)V

    goto :goto_1

    :cond_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->e(Ljava/lang/String;)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->d(Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090031 -> :sswitch_4
        0x7f090254 -> :sswitch_3
        0x7f09039c -> :sswitch_2
        0x7f0903a4 -> :sswitch_1
        0x7f0904a6 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0171

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->C()V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "ignorePhoneFriend"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p1

    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaSuggestedFriendListActivity;->j:Z

    return-void
.end method
