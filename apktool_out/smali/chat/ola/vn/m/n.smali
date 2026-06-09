.class public Lchat/ola/vn/m/n;
.super Lchat/ola/vn/m/p;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Lchat/ola/vn/p/f;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/m/p<",
        "Lchat/ola/vn/m/e;",
        ">;",
        "Landroid/view/View$OnClickListener;",
        "Landroid/widget/AbsListView$OnScrollListener;",
        "Landroid/widget/AdapterView$OnItemClickListener;",
        "Landroid/widget/AdapterView$OnItemLongClickListener;",
        "Lchat/ola/vn/p/f;"
    }
.end annotation


# instance fields
.field private a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private b:Landroid/widget/ListView;

.field private d:Lchat/ola/vn/message/g;

.field private e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private f:Landroid/app/ProgressDialog;

.field private g:Ljava/lang/Runnable;

.field private h:Ljava/lang/String;

.field private i:Landroid/os/Parcelable;

.field private j:I

.field private k:I

.field private l:Lchat/ola/vn/b/q;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/p;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/m/n;->h:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/m/n;->i:Landroid/os/Parcelable;

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/m/n;->j:I

    iput v0, p0, Lchat/ola/vn/m/n;->k:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/n;Lchat/ola/vn/message/f;)Lchat/ola/vn/i/f;
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/n;->a(Lchat/ola/vn/message/f;)Lchat/ola/vn/i/f;

    move-result-object p0

    return-object p0
.end method

.method private a(Lchat/ola/vn/message/f;)Lchat/ola/vn/i/f;
    .locals 7

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f05ce

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const v4, 0x7f0f01d6

    invoke-virtual {p0, v4, v3}, Lchat/ola/vn/m/n;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v1, 0x7f0f044d

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/m/n$5;

    invoke-direct {v6, p0, p1}, Lchat/ola/vn/m/n$5;-><init>(Lchat/ola/vn/m/n;Lchat/ola/vn/message/f;)V

    move-object v1, v2

    move-object v2, v3

    move-object v3, v4

    move-object v4, v5

    move-object v5, v6

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    move-result-object p1

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/m/n;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    return-object p0
.end method

.method private a(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    instance-of v0, v0, Ljava/lang/String;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    const v0, 0x7f0f05fa

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/ContactFinderActivity;->a(Landroid/content/Context;)V

    :cond_0
    return-void
.end method

.method private a(Landroid/view/View;Lchat/ola/vn/message/f;)V
    .locals 2

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f0463

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f05e7

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f05ce

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v1, Lchat/ola/vn/m/n$1;

    invoke-direct {v1, p0, p1, p2}, Lchat/ola/vn/m/n$1;-><init>(Lchat/ola/vn/m/n;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/n;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/n;->e(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/n;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/n;->a(Z)V

    return-void
.end method

.method private a(Z)V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/i/j;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/m/n$7;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/m/n$7;-><init>(Lchat/ola/vn/m/n;Z)V

    invoke-direct {v0, v1, p1, v2}, Lchat/ola/vn/i/j;-><init>(Landroid/content/Context;ZLchat/ola/vn/i/j$a;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/j;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/n;)Lchat/ola/vn/b/q;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/n;->l:Lchat/ola/vn/b/q;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/m/n;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/n;->b(Z)V

    return-void
.end method

.method private b(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->g:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/m/n$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/n$4;-><init>(Lchat/ola/vn/m/n;)V

    iput-object v0, p0, Lchat/ola/vn/m/n;->g:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->g:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_2

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/m/n;->f:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f0f05ad

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f01d8

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/n;->f:Landroid/app/ProgressDialog;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/n;->f:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/m/n;->g:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/m/n;->f:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private e()V
    .locals 0

    return-void
.end method

.method private e(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->f:Landroid/app/ProgressDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/n;->f:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    return-void

    :catch_0
    :cond_0
    const/4 v0, 0x0

    :try_start_1
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->x:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    const/4 v1, 0x0

    :goto_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 v2, 0x1

    invoke-direct {p0, v2}, Lchat/ola/vn/m/n;->b(Z)V

    if-eqz v1, :cond_1

    invoke-static {p1}, Lchat/ola/vn/util/m;->t(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "name"

    aput-object v3, v2, v0

    new-instance v0, Lchat/ola/vn/m/n$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/n$2;-><init>(Lchat/ola/vn/m/n;)V

    invoke-virtual {v1, p1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void

    :cond_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/m/n$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/n$3;-><init>(Lchat/ola/vn/m/n;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/i;)V

    :cond_2
    return-void
.end method

.method private j()V
    .locals 2

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->m()B

    move-result v0

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->g()Ljava/lang/Object;

    move-result-object v0

    :goto_0
    check-cast v0, Lchat/ola/vn/m/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/e;->a(Z)V

    return-void

    :pswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->g()Ljava/lang/Object;

    move-result-object v0

    goto :goto_0

    :pswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->g()Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    :pswitch_3
    const/4 v0, 0x1

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->g()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/m/e;

    invoke-virtual {v1, v0}, Lchat/ola/vn/m/e;->a(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/g;->a(B)V

    new-instance v0, Lchat/ola/vn/m/n$8;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/n$8;-><init>(Lchat/ola/vn/m/n;)V

    invoke-static {v0}, Lchat/ola/vn/h;->a(Ljava/lang/Runnable;)V

    :catch_1
    :cond_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private v()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->g()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/e;

    invoke-virtual {v0}, Lchat/ola/vn/m/e;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public C()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public H()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public a(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 0
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

    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/p;->a(Landroid/os/Bundle;)V

    if-eqz p1, :cond_0

    const-string v0, "contact_scroll_parcelable"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/n;->i:Landroid/os/Parcelable;

    const-string v0, "contact_scroll_offset"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/m/n;->j:I

    const-string v0, "contact_scroll_top_position"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/m/n;->k:I

    return-void

    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/m/n;->i:Landroid/os/Parcelable;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;S)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/p;->a(Lchat/ola/vn/entity/ag;S)V

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/d;BB)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;ILjava/lang/String;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "I",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/Short;I)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/p;->a(Ljava/lang/Short;I)V

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a_()V
    .locals 0

    return-void
.end method

.method public b(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/p;->b(Landroid/os/Bundle;)V

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/n;->setHasOptionsMenu(Z)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iput-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    iget-object p1, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/p/f;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->c()V

    invoke-direct {p0}, Lchat/ola/vn/m/n;->v()V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/Short;I)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/n;->e()V

    return-void
.end method

.method public c(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public c()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/n;->e()V

    iget-object v0, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->notifyDataSetChanged()V

    return-void
.end method

.method public c(I)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->notifyDataSetChanged()V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/m/n;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public c(Z)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public d(Lchat/ola/vn/message/f;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public e(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public f(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public f_()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->smoothScrollToPosition(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public g(Lchat/ola/vn/message/f;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public h_()Landroid/app/Dialog;
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sget-short v1, Lchat/ola/vn/h;->H:S

    if-gtz v1, :cond_0

    const v1, 0x7f0f0444

    :goto_0
    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    sget v1, Lchat/ola/vn/h;->K:I

    const/4 v2, 0x3

    if-gt v1, v2, :cond_1

    const v1, 0x7f0f0445

    goto :goto_0

    :cond_1
    :goto_1
    const v1, 0x7f0f045d

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f054e

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f054f

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/n;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :try_start_0
    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/n$6;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/m/n$6;-><init>(Lchat/ola/vn/m/n;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public i()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public i_()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/n;->h:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "chat.ola.vn.fragment.OlaContactListSection"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/n;->h:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->h:Ljava/lang/String;

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->h_()Landroid/app/Dialog;

    return-void

    :sswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/m/n;->e:Ljava/util/ArrayList;

    invoke-static {v3}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v3

    invoke-static {v0, p1, v2, v1, v3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :sswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-static {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-static {v3, p1, v2, v1, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-eqz v1, :cond_1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_0

    return-void

    :cond_0
    invoke-direct {p0, p1, v0}, Lchat/ola/vn/m/n;->a(Landroid/view/View;Lchat/ola/vn/message/f;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_5
    invoke-direct {p0, p1}, Lchat/ola/vn/m/n;->a(Landroid/view/View;)V

    return-void

    :sswitch_6
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAddContactActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :sswitch_7
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f09002e -> :sswitch_6
        0x7f0900d6 -> :sswitch_7
        0x7f0901ca -> :sswitch_5
        0x7f090281 -> :sswitch_4
        0x7f090297 -> :sswitch_3
        0x7f090495 -> :sswitch_2
        0x7f090496 -> :sswitch_1
        0x7f0905ef -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/p;->onCreate(Landroid/os/Bundle;)V

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const/4 p2, 0x0

    const p3, 0x7f0b014e

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p3

    const v0, 0x7f09002e

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090314

    invoke-virtual {p3, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    const v0, 0x7f0b009e

    :try_start_0
    invoke-virtual {p1, v0, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090452

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object p2, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const p2, 0x7f0f04e0

    :try_start_1
    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const v1, 0x7f0f04dd

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v0, p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-virtual {v0, p2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    :goto_0
    const p2, 0x7f090453

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    new-instance v0, Lchat/ola/vn/m/n$9;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/n$9;-><init>(Lchat/ola/vn/m/n;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/m/n$10;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/n$10;-><init>(Lchat/ola/vn/m/n;)V

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/m/n$11;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/n$11;-><init>(Lchat/ola/vn/m/n;)V

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    new-instance p2, Lchat/ola/vn/b/q;

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p2, v0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/m/n;->l:Lchat/ola/vn/b/q;

    iget-object p2, p0, Lchat/ola/vn/m/n;->l:Lchat/ola/vn/b/q;

    new-instance v0, Lchat/ola/vn/b/q$a;

    iget-object v1, p0, Lchat/ola/vn/m/n;->l:Lchat/ola/vn/b/q;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v0, v1}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object p2, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/m/n;->l:Lchat/ola/vn/b/q;

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object p2, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/m/n$12;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/n$12;-><init>(Lchat/ola/vn/m/n;)V

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    invoke-virtual {p2, p1}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-object p3
.end method

.method public onDestroy()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/m/p;->onDestroy()V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/p/f;)V

    return-void
.end method

.method public onDetach()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/m/p;->onDetach()V

    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 6
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
    iget-object p1, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    if-eqz p1, :cond_0

    add-int/lit8 p3, p3, -0x1

    :cond_0
    move v3, p3

    iget-object v0, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    move-object v2, p2

    move-wide v4, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/message/g;->b(Landroid/content/Context;Landroid/view/View;IJ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 6
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
    iget-object p1, p0, Lchat/ola/vn/m/n;->a:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    if-eqz p1, :cond_0

    add-int/lit8 p3, p3, -0x1

    :cond_0
    move v3, p3

    iget-object v0, p0, Lchat/ola/vn/m/n;->d:Lchat/ola/vn/message/g;

    invoke-virtual {p0}, Lchat/ola/vn/m/n;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    move-object v2, p2

    move-wide v4, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/message/g;->a(Landroid/content/Context;Landroid/view/View;IJ)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public onPause()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/m/p;->onPause()V

    return-void
.end method

.method public onResume()V
    .locals 3

    invoke-super {p0}, Lchat/ola/vn/m/p;->onResume()V

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->r()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/n;->c()V

    invoke-direct {p0}, Lchat/ola/vn/m/n;->j()V

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/m/n;->i:Landroid/os/Parcelable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/m/n;->i:Landroid/os/Parcelable;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/m/n;->i:Landroid/os/Parcelable;

    :cond_0
    iget v0, p0, Lchat/ola/vn/m/n;->j:I

    if-ltz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    iget v1, p0, Lchat/ola/vn/m/n;->j:I

    iget v2, p0, Lchat/ola/vn/m/n;->k:I

    invoke-virtual {v0, v1, v2}, Landroid/widget/ListView;->setSelectionFromTop(II)V

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/m/n;->j:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    iget v1, p0, Lchat/ola/vn/m/n;->j:I

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setSelection(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_1
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 3

    if-eqz p1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    if-eqz v0, :cond_2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/widget/ListView;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "contact_scroll_parcelable"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    :cond_0
    const-string v0, "contact_scroll_offset"

    iget-object v1, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    invoke-virtual {v1}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    iget-object v0, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    const-string v2, "contact_scroll_top_position"

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Landroid/view/View;->getTop()I

    move-result v1

    :goto_0
    invoke-virtual {p1, v2, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    const-string v0, "contact_scroll_offset"

    iget-object v1, p0, Lchat/ola/vn/m/n;->b:Landroid/widget/ListView;

    invoke-virtual {v1}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    :cond_2
    :goto_1
    invoke-super {p0, p1}, Lchat/ola/vn/m/p;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    return-void
.end method
