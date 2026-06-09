.class public Lchat/ola/vn/m/l;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "RtlHardcoded"
    }
.end annotation


# static fields
.field private static r:I = -0x1

.field private static s:I = -0x1

.field private static t:I = -0x1

.field private static u:I = -0x1

.field private static v:J

.field private static w:J


# instance fields
.field private A:Landroid/view/animation/Animation;

.field private B:J

.field private C:Landroid/widget/ImageView;

.field a:Ljava/lang/Runnable;

.field private b:Landroid/widget/ListView;

.field private c:Landroid/widget/ListView;

.field private d:Lchat/ola/vn/b/y;

.field private e:Lchat/ola/vn/b/z;

.field private f:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private g:Landroid/view/View;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/view/View;

.field private j:Landroid/widget/ImageButton;

.field private k:Landroid/widget/TextView;

.field private l:Landroid/widget/TextView;

.field private o:Landroid/widget/TextView;

.field private p:Landroid/support/v4/widget/DrawerLayout;

.field private q:Z

.field private x:Ljava/lang/Runnable;

.field private y:Landroid/view/animation/Animation;

.field private z:Landroid/view/animation/Animation;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/m/l;->q:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/m/l;->B:J

    return-void
.end method

.method private A()V
    .locals 3

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/m/l;->q:Z

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {v1, v2}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v1, v0}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method

.method private B()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/l;->q:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    iput-boolean v1, p0, Lchat/ola/vn/m/l;->q:Z

    return-void
.end method

.method private C()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/l;->q:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    iput-boolean v1, p0, Lchat/ola/vn/m/l;->q:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/l;Landroid/view/animation/Animation;)Landroid/view/animation/Animation;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/l;->z:Landroid/view/animation/Animation;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 1

    const/16 v0, 0xe

    invoke-static {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    return-void
.end method

.method private a(Lchat/ola/vn/entity/s;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->h()B

    move-result v0

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->b(Lchat/ola/vn/entity/s;)V

    return-void

    :pswitch_1
    :try_start_0
    invoke-static {}, Lcom/facebook/share/widget/AppInviteDialog;->canShow()Z

    move-result p1

    if-eqz p1, :cond_0

    new-instance p1, Lcom/facebook/share/model/AppInviteContent$Builder;

    invoke-direct {p1}, Lcom/facebook/share/model/AppInviteContent$Builder;-><init>()V

    const-string v0, "https://fb.me/1199434326766314"

    invoke-virtual {p1, v0}, Lcom/facebook/share/model/AppInviteContent$Builder;->setApplinkUrl(Ljava/lang/String;)Lcom/facebook/share/model/AppInviteContent$Builder;

    move-result-object p1

    const-string v0, "http://s1.cdn.kaspee.com/ola/preview.jpg"

    invoke-virtual {p1, v0}, Lcom/facebook/share/model/AppInviteContent$Builder;->setPreviewImageUrl(Ljava/lang/String;)Lcom/facebook/share/model/AppInviteContent$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/share/model/AppInviteContent$Builder;->build()Lcom/facebook/share/model/AppInviteContent;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/facebook/share/widget/AppInviteDialog;->show(Landroid/app/Activity;Lcom/facebook/share/model/AppInviteContent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :pswitch_2
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->a(Z)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(S)V

    return-void

    :pswitch_3
    iget-object p1, p1, Lchat/ola/vn/entity/s;->a:Lchat/ola/vn/entity/k;

    iget-object v0, p1, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entity/k;->h:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p1, p1, Lchat/ola/vn/entity/k;->g:Ljava/lang/String;

    const-string v1, "wap"

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :pswitch_4
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_4
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method static synthetic a(Lchat/ola/vn/m/l;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/l;->A()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/l;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->a(Z)V

    return-void
.end method

.method private a(Lchat/ola/vn/message/f;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/l;->A:Landroid/view/animation/Animation;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f010032

    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/l;->A:Landroid/view/animation/Animation;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    if-eqz p1, :cond_1

    :try_start_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->z()I

    move-result p1

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    :goto_0
    if-lez p1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/m/l;->l:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/l;->l:Landroid/widget/TextView;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/m/l;->A:Landroid/view/animation/Animation;

    invoke-virtual {p1}, Landroid/view/animation/Animation;->cancel()V

    iget-object p1, p0, Lchat/ola/vn/m/l;->j:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/m/l;->A:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setAnimation(Landroid/view/animation/Animation;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/m/l;->A:Landroid/view/animation/Animation;

    invoke-virtual {p1}, Landroid/view/animation/Animation;->cancel()V

    iget-object p1, p0, Lchat/ola/vn/m/l;->l:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method private a(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/l;->g:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/l;->a:Ljava/lang/Runnable;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/m/l$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/l$3;-><init>(Lchat/ola/vn/m/l;)V

    iput-object v0, p0, Lchat/ola/vn/m/l;->a:Ljava/lang/Runnable;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/l;->a:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/l;->a:Ljava/lang/Runnable;

    const-wide/32 v0, 0xea60

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method private b(Lchat/ola/vn/entity/s;)V
    .locals 9

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/m/l;->a(Z)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->e()Z

    move-result v1

    if-eqz v1, :cond_4

    const/4 p1, 0x0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->d()[Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v2, :cond_1

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-wide/16 v4, -0x1

    aget-object v6, v1, p1

    aget-object v7, v1, v0

    const/4 v8, 0x0

    invoke-virtual/range {v3 .. v8}, Lchat/ola/vn/network/OlaNetworkService;->a(JLjava/lang/String;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return-void

    :catch_0
    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->a(Z)V

    const/16 p1, 0x65

    invoke-static {p0, p1}, Lchat/ola/vn/n/b;->a(Landroid/support/v4/app/Fragment;I)V

    return-void

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/m/l;->x()V

    return-void

    :cond_4
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v1

    const/4 v3, 0x1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(JZLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/l;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/l;->y()V

    return-void
.end method

.method static synthetic c()I
    .locals 1

    sget v0, Lchat/ola/vn/m/l;->t:I

    return v0
.end method

.method static synthetic c(Lchat/ola/vn/m/l;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/l;->z()V

    return-void
.end method

.method static synthetic d()I
    .locals 1

    sget v0, Lchat/ola/vn/m/l;->r:I

    return v0
.end method

.method static synthetic d(Lchat/ola/vn/m/l;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    return-object p0
.end method

.method static synthetic e()I
    .locals 1

    sget v0, Lchat/ola/vn/m/l;->u:I

    return v0
.end method

.method static synthetic e(Lchat/ola/vn/m/l;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/l;->g:Landroid/view/View;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/m/l;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/l;->x()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/m/l;)Landroid/view/animation/Animation;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/l;->z:Landroid/view/animation/Animation;

    return-object p0
.end method

.method static synthetic h()I
    .locals 1

    sget v0, Lchat/ola/vn/m/l;->s:I

    return v0
.end method

.method static synthetic h(Lchat/ola/vn/m/l;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/m/l;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/l;->v()V

    return-void
.end method

.method private j()V
    .locals 11

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->e()I

    move-result v0

    const/4 v1, 0x4

    const/4 v2, 0x0

    if-nez v0, :cond_0

    iget-object v3, p0, Lchat/ola/vn/m/l;->C:Landroid/widget/ImageView;

    invoke-virtual {v3, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/m/l;->C:Landroid/widget/ImageView;

    invoke-virtual {v3, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    sget-object v3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v3}, Lchat/ola/vn/r/a/f;->r()Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lchat/ola/vn/m/l;->C:Landroid/widget/ImageView;

    const v4, 0x7f0806bb

    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/m/l;->C:Landroid/widget/ImageView;

    const v4, 0x7f0806bc

    invoke-virtual {v3, v4}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :goto_0
    const/4 v3, -0x1

    :try_start_1
    iget-object v4, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    invoke-virtual {v4}, Landroid/widget/ListView;->getTag()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v4
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move v3, v4

    :catch_0
    const/4 v4, 0x1

    if-eq v3, v0, :cond_9

    const/16 v3, 0x8

    const/4 v5, 0x3

    if-eqz v0, :cond_5

    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/m/l;->p:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v1, v2, v5}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->k:Landroid/widget/TextView;

    sget-object v5, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v5}, Lchat/ola/vn/r/a/f;->j()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->h:Landroid/widget/TextView;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->c()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/m/l;->i:Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->j:Landroid/widget/ImageButton;

    const v3, 0x7f080749

    invoke-virtual {v1, v3}, Landroid/widget/ImageButton;->setImageResource(I)V

    goto :goto_1

    :cond_2
    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v5

    const-wide/16 v7, 0x0

    cmp-long v1, v5, v7

    if-gtz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/m/l;->i:Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->j:Landroid/widget/ImageButton;

    const v3, 0x7f08070a

    invoke-virtual {v1, v3}, Landroid/widget/ImageButton;->setImageResource(I)V

    goto :goto_1

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/m/l;->i:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :goto_1
    :try_start_3
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v3}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v5

    invoke-virtual {v1, v5, v6}, Lchat/ola/vn/message/g;->a(J)Lchat/ola/vn/message/f;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-direct {p0, v1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/message/f;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :cond_4
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v1, v4}, Landroid/support/v4/widget/SwipeRefreshLayout;->setEnabled(Z)V

    invoke-direct {p0, v2}, Lchat/ola/vn/m/l;->a(Z)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    iget-object v2, p0, Lchat/ola/vn/m/l;->e:Lchat/ola/vn/b/z;

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/m/l;->c:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/m/l;->d:Lchat/ola/vn/b/y;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/m/l;->d:Lchat/ola/vn/b/y;

    invoke-virtual {v0}, Lchat/ola/vn/b/y;->notifyDataSetChanged()V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/m/l;->e:Lchat/ola/vn/b/z;

    invoke-virtual {v0}, Lchat/ola/vn/b/z;->notifyDataSetChanged()V

    goto/16 :goto_5

    :cond_5
    iget-object v6, p0, Lchat/ola/vn/m/l;->p:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v6, v4, v5}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    iget-object v5, p0, Lchat/ola/vn/m/l;->k:Landroid/widget/TextView;

    const v6, 0x7f0f046c

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setText(I)V

    iget-object v5, p0, Lchat/ola/vn/m/l;->h:Landroid/widget/TextView;

    invoke-virtual {v5, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->i:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v1, v4}, Landroid/support/v4/widget/SwipeRefreshLayout;->setEnabled(Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sget-wide v7, Lchat/ola/vn/m/l;->v:J

    const/4 v1, 0x0

    sub-long v9, v5, v7

    const-wide/32 v5, 0xdbba0

    cmp-long v1, v9, v5

    if-ltz v1, :cond_6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sput-wide v5, Lchat/ola/vn/m/l;->v:J

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->b()V

    :cond_6
    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->f()I

    move-result v1

    if-lez v1, :cond_7

    invoke-direct {p0, v2}, Lchat/ola/vn/m/l;->a(Z)V

    goto :goto_3

    :cond_7
    invoke-direct {p0, v4}, Lchat/ola/vn/m/l;->a(Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sget-wide v5, Lchat/ola/vn/m/l;->w:J

    const/4 v1, 0x0

    sub-long v7, v3, v5

    const-wide/32 v3, 0x2bf20

    cmp-long v1, v7, v3

    if-ltz v1, :cond_8

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sput-wide v3, Lchat/ola/vn/m/l;->w:J

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(S)V

    :cond_8
    :goto_3
    iget-object v1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    iget-object v2, p0, Lchat/ola/vn/m/l;->d:Lchat/ola/vn/b/y;

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->setTag(Ljava/lang/Object;)V

    :goto_4
    iget-object v0, p0, Lchat/ola/vn/m/l;->d:Lchat/ola/vn/b/y;

    invoke-virtual {v0}, Lchat/ola/vn/b/y;->notifyDataSetChanged()V

    goto :goto_5

    :cond_9
    if-eqz v0, :cond_a

    invoke-direct {p0, v2}, Lchat/ola/vn/m/l;->a(Z)V

    goto/16 :goto_2

    :cond_a
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->f()I

    move-result v0

    if-lez v0, :cond_b

    invoke-direct {p0, v2}, Lchat/ola/vn/m/l;->a(Z)V

    goto :goto_4

    :cond_b
    invoke-direct {p0, v4}, Lchat/ola/vn/m/l;->a(Z)V

    goto :goto_4

    :goto_5
    iget-object v0, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/m/l$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/l$2;-><init>(Lchat/ola/vn/m/l;)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->post(Ljava/lang/Runnable;)Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    return-void
.end method

.method private v()V
    .locals 9

    const/4 v0, 0x0

    sput v0, Lchat/ola/vn/m/l;->t:I

    sput v0, Lchat/ola/vn/m/l;->r:I

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sput-wide v1, Lchat/ola/vn/m/l;->v:J

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->b()V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v2, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->c(J)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/lang/Long;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Z)V

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->d()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iget-wide v5, p0, Lchat/ola/vn/m/l;->B:J

    sub-long v7, v3, v5

    const-wide/32 v3, 0x493e0

    cmp-long v1, v7, v3

    if-lez v1, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, p0, Lchat/ola/vn/m/l;->B:J

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(S)V

    :cond_0
    invoke-direct {p0, v2}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/message/f;)V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->j()V

    return-void
.end method

.method private x()V
    .locals 4

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/m/l$6;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/l$6;-><init>(Lchat/ola/vn/m/l;)V

    const-wide/16 v2, 0x7530

    invoke-static {v0, v2, v3, v1}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V

    return-void
.end method

.method private y()V
    .locals 8

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/m/l;->a(Z)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/h/b;->i(Ljava/lang/String;)Z

    move-result v4

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v5

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v6

    const/4 v7, 0x0

    invoke-virtual/range {v1 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(JZLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method private z()V
    .locals 2

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/m/l;->a(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(S)V

    return-void
.end method


# virtual methods
.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 6

    const/4 p2, 0x0

    invoke-direct {p0, p2}, Lchat/ola/vn/m/l;->a(Z)V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->C()V

    const/16 p2, 0xe

    if-eq p1, p2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f009b

    const v2, 0x7f0f033b

    const v3, 0x7f0f0444

    const v4, 0x7f0f0480

    new-instance v5, Lchat/ola/vn/m/l$4;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/l$4;-><init>(Lchat/ola/vn/m/l;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method

.method public a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->a(Z)V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->B()V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->j()V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;S)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/a;->a(Lchat/ola/vn/entity/ag;S)V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 4

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->e()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_6

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v2, 0x4

    if-ne v0, v2, :cond_6

    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/message/f;)V

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->x()Z

    move-result v0

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object p2, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    const v0, 0x7f0f031b

    new-array v1, v1, [Ljava/lang/Object;

    aput-object p1, v1, v2

    invoke-static {v0, v1}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    invoke-virtual {p2}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    const/4 v3, 0x3

    if-ne v0, v3, :cond_1

    iget-object p2, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    const v0, 0x7f0f031e

    new-array v1, v1, [Ljava/lang/Object;

    aput-object p1, v1, v2

    invoke-static {v0, v1}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    invoke-virtual {p2}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    const/4 v3, 0x6

    if-ne v0, v3, :cond_2

    iget-object p2, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    const v0, 0x7f0f0322

    new-array v1, v1, [Ljava/lang/Object;

    aput-object p1, v1, v2

    invoke-static {v0, v1}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    invoke-virtual {p2}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    const/16 v1, 0xe

    if-ne v0, v1, :cond_3

    iget-object p2, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ": "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0636

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ": "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->l()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/m/l;->y:Landroid/view/animation/Animation;

    if-nez p1, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const p2, 0x7f01004d

    invoke-static {p1, p2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/l;->y:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/m/l;->y:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x96

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/m/l;->y:Landroid/view/animation/Animation;

    invoke-virtual {p1}, Landroid/view/animation/Animation;->cancel()V

    iget-object p1, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/m/l;->y:Landroid/view/animation/Animation;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/m/l;->x:Ljava/lang/Runnable;

    if-nez p1, :cond_5

    new-instance p1, Lchat/ola/vn/m/l$7;

    invoke-direct {p1, p0}, Lchat/ola/vn/m/l$7;-><init>(Lchat/ola/vn/m/l;)V

    iput-object p1, p0, Lchat/ola/vn/m/l;->x:Ljava/lang/Runnable;

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    iget-object p2, p0, Lchat/ola/vn/m/l;->x:Ljava/lang/Runnable;

    invoke-virtual {p1, p2}, Landroid/widget/ListView;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object p1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    iget-object p2, p0, Lchat/ola/vn/m/l;->x:Ljava/lang/Runnable;

    const-wide/16 v0, 0x1388

    invoke-virtual {p1, p2, v0, v1}, Landroid/widget/ListView;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_6
    return-void
.end method

.method public a(Ljava/lang/Short;I)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/a;->a(Ljava/lang/Short;I)V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/s;",
            ">;S)V"
        }
    .end annotation

    invoke-direct {p0}, Lchat/ola/vn/m/l;->B()V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->j()V

    return-void
.end method

.method public g_()Z
    .locals 8

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->e()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const v0, 0x7f0f05cf

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/l;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f04c4

    new-array v4, v1, [Ljava/lang/Object;

    const/4 v5, 0x0

    sget-object v6, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v6}, Lchat/ola/vn/r/a/f;->j()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-virtual {p0, v0, v4}, Lchat/ola/vn/m/l;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f06c2

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/l;->getString(I)Ljava/lang/String;

    move-result-object v5

    const v0, 0x7f0f0577

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/l;->getString(I)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lchat/ola/vn/m/l$8;

    invoke-direct {v7, p0}, Lchat/ola/vn/m/l$8;-><init>(Lchat/ola/vn/m/l;)V

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return v1

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/m/a;->g_()Z

    move-result v0

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const/4 v0, 0x0

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long p1, v1, v3

    if-gtz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/m/h;->a(Landroid/content/Context;)V

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v1

    invoke-virtual {p1, v1, v2}, Lchat/ola/vn/message/g;->a(J)Lchat/ola/vn/message/f;

    move-result-object p1

    if-nez p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v1

    invoke-virtual {p1, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(J)Lchat/ola/vn/message/f;

    move-result-object p1

    :cond_1
    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->a(I)V

    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/message/f;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v2, 0x0

    invoke-static {v0, v1, p1, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;Lchat/ola/vn/entity/n;)V

    return-void

    :sswitch_1
    iget-object p1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->smoothScrollToPosition(I)V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_3
    invoke-direct {p0}, Lchat/ola/vn/m/l;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f09039c -> :sswitch_3
        0x7f0903a1 -> :sswitch_2
        0x7f0903a4 -> :sswitch_1
        0x7f090426 -> :sswitch_0
        0x7f090427 -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const p3, 0x7f0b0166

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09042c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    const p2, 0x7f090429

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/support/v4/widget/DrawerLayout;

    iput-object p2, p0, Lchat/ola/vn/m/l;->p:Landroid/support/v4/widget/DrawerLayout;

    const p2, 0x7f09042a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lchat/ola/vn/m/l;->c:Landroid/widget/ListView;

    const p2, 0x7f09042e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object p2, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object p2, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 p3, 0x1

    new-array p3, p3, [I

    const v1, 0x7f06003d

    aput v1, p3, v0

    invoke-virtual {p2, p3}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object p2, p0, Lchat/ola/vn/m/l;->f:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance p3, Lchat/ola/vn/m/l$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/l$1;-><init>(Lchat/ola/vn/m/l;)V

    invoke-virtual {p2, p3}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    const p2, 0x7f09042d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/l;->g:Landroid/view/View;

    const p2, 0x7f090428

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/l;->i:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/m/l;->i:Landroid/view/View;

    const/16 p3, 0x8

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    const p2, 0x7f090427

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageButton;

    iput-object p2, p0, Lchat/ola/vn/m/l;->j:Landroid/widget/ImageButton;

    iget-object p2, p0, Lchat/ola/vn/m/l;->j:Landroid/widget/ImageButton;

    invoke-virtual {p2, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0903a3

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/m/l;->k:Landroid/widget/TextView;

    const p2, 0x7f090433

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/m/l;->l:Landroid/widget/TextView;

    const p2, 0x7f090426

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/m/l;->o:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09039c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/m/l;->h:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/m/l;->h:Landroid/widget/TextView;

    const v0, 0x7f0f042c

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(I)V

    iget-object p2, p0, Lchat/ola/vn/m/l;->h:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0903a4

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance p2, Lchat/ola/vn/b/y;

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p2, v0}, Lchat/ola/vn/b/y;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/m/l;->d:Lchat/ola/vn/b/y;

    new-instance p2, Lchat/ola/vn/b/z;

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p2, v0}, Lchat/ola/vn/b/z;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/m/l;->e:Lchat/ola/vn/b/z;

    iget-object p2, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    invoke-virtual {p2, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/l;->c:Landroid/widget/ListView;

    invoke-virtual {p2, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    const p2, 0x7f09039e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    const p2, 0x7f0903a1

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/m/l;->C:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/m/l;->C:Landroid/widget/ImageView;

    const p3, 0x7f0806bb

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p2, p0, Lchat/ola/vn/m/l;->C:Landroid/widget/ImageView;

    invoke-virtual {p2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    new-instance p1, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1
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
    iget-object p2, p0, Lchat/ola/vn/m/l;->p:Landroid/support/v4/widget/DrawerLayout;

    const/4 p4, 0x3

    invoke-virtual {p2, p4}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V

    iget-object p2, p0, Lchat/ola/vn/m/l;->c:Landroid/widget/ListView;

    if-ne p1, p2, :cond_0

    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    :goto_0
    invoke-virtual {p1, p3}, Lchat/ola/vn/r/a/f;->b(I)Lchat/ola/vn/entity/s;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/m/l;->a(Lchat/ola/vn/entity/s;)V

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/f;->e()I

    move-result p1

    if-nez p1, :cond_1

    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    goto :goto_0

    :cond_1
    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1, p3}, Lchat/ola/vn/r/a/f;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x6

    if-ne p2, p3, :cond_2

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p2, p3, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0
    .param p2    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p3    # [I
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    const/16 p2, 0x65

    if-ne p1, p2, :cond_1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    new-instance p1, Lchat/ola/vn/m/l$5;

    invoke-direct {p1, p0}, Lchat/ola/vn/m/l$5;-><init>(Lchat/ola/vn/m/l;)V

    const-wide/16 p2, 0x1f4

    invoke-static {p1, p2, p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/l;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const p2, 0x7f0f00a2

    const p3, 0x7f0f0336

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public onResume()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/m/a;->onResume()V

    invoke-direct {p0}, Lchat/ola/vn/m/l;->j()V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/l;->b:Landroid/widget/ListView;

    const/4 p3, 0x0

    invoke-virtual {p1, p3}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    sget-object p4, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p4}, Lchat/ola/vn/r/a/f;->e()I

    move-result p4

    const/4 v0, 0x1

    if-ne p4, v0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p3

    :goto_0
    sput p3, Lchat/ola/vn/m/l;->r:I

    sput p2, Lchat/ola/vn/m/l;->t:I

    return-void

    :cond_1
    if-nez p1, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p3

    :goto_1
    sput p3, Lchat/ola/vn/m/l;->s:I

    sput p2, Lchat/ola/vn/m/l;->u:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    return-void
.end method
