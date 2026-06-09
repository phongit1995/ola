.class public Lchat/ola/vn/m/k;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field public static a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/j;",
            ">;"
        }
    .end annotation
.end field

.field private static b:Lchat/ola/vn/m/k;

.field private static e:J

.field private static f:J


# instance fields
.field private c:Landroid/widget/ListView;

.field private d:Lchat/ola/vn/b/x;

.field private g:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private h:Z

.field private i:Z

.field private j:Landroid/view/View;

.field private k:Landroid/view/View;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lchat/ola/vn/m/k;->a:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/m/k;->h:Z

    return-void
.end method

.method static synthetic a(J)J
    .locals 0

    sput-wide p0, Lchat/ola/vn/m/k;->e:J

    return-wide p0
.end method

.method static synthetic a(Lchat/ola/vn/m/k;)Lchat/ola/vn/b/x;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    return-object p0
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    const-wide/16 v0, 0x0

    sput-wide v0, Lchat/ola/vn/m/k;->e:J

    const-wide/16 v0, -0x1

    sput-wide v0, Lchat/ola/vn/m/k;->f:J

    sget-object v0, Lchat/ola/vn/m/k;->a:Ljava/util/List;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/k;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->I()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    const v1, 0x7f0f00f1

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/c;->b(I)Lchat/ola/vn/entry/e;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/e;->b(I)V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V

    :cond_1
    invoke-static {}, Lchat/ola/vn/m/d;->c()Lchat/ola/vn/m/d;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/m/d;->c()Lchat/ola/vn/m/d;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/d;->d()V

    :cond_2
    const/16 v0, 0x9

    invoke-static {p0, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/k;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/k;->a(Z)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/k;[Lchat/ola/vn/entity/j;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/k;->a([Lchat/ola/vn/entity/j;I)V

    return-void
.end method

.method private a(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/k;->j:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private a([Lchat/ola/vn/entity/j;I)V
    .locals 4

    const/4 p2, 0x0

    const/16 v0, 0x8

    if-eqz p1, :cond_1

    array-length v1, p1

    if-lez v1, :cond_1

    array-length v1, p1

    :goto_0
    if-ge p2, v1, :cond_0

    aget-object v2, p1, p2

    sget-object v3, Lchat/ola/vn/m/k;->a:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    invoke-virtual {p2}, Lchat/ola/vn/b/x;->notifyDataSetChanged()V

    array-length p2, p1

    add-int/lit8 p2, p2, -0x1

    aget-object p1, p1, p2

    iget-wide p1, p1, Lchat/ola/vn/entity/j;->h:J

    sput-wide p1, Lchat/ola/vn/m/k;->e:J

    iget-object p1, p0, Lchat/ola/vn/m/k;->j:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/k;->k:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/k;->c:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getLastVisiblePosition()I

    move-result p1

    iget-object p2, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    invoke-virtual {p2}, Lchat/ola/vn/b/x;->getCount()I

    move-result p2

    add-int/lit8 p2, p2, -0x1

    if-lt p1, p2, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/m/k;->d()V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/k;->j:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/k;->k:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void
.end method

.method static synthetic b(J)J
    .locals 0

    sput-wide p0, Lchat/ola/vn/m/k;->f:J

    return-wide p0
.end method

.method static synthetic b(Lchat/ola/vn/m/k;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/k;->d()V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/m/k;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/k;->e()V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/m/k;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/k;->j:Landroid/view/View;

    return-object p0
.end method

.method private d()V
    .locals 5

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lchat/ola/vn/m/k;->h:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/k;->j:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/k;->k:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    sget-wide v0, Lchat/ola/vn/m/k;->f:J

    sget-wide v2, Lchat/ola/vn/m/k;->e:J

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-wide v1, Lchat/ola/vn/m/k;->e:J

    const/4 v3, 0x1

    new-instance v4, Lchat/ola/vn/m/k$2;

    invoke-direct {v4, p0}, Lchat/ola/vn/m/k$2;-><init>(Lchat/ola/vn/m/k;)V

    invoke-static {v4}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(JZS)V

    sget-wide v0, Lchat/ola/vn/m/k;->e:J

    sput-wide v0, Lchat/ola/vn/m/k;->f:J

    :cond_1
    return-void
.end method

.method static synthetic e(Lchat/ola/vn/m/k;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/k;->k:Landroid/view/View;

    return-object p0
.end method

.method private e()V
    .locals 3

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/m/k;->h:Z

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {v1, v2}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/k;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v1, v0}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/m/k;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/k;->j()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/m/k;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/k;->h()V

    return-void
.end method

.method private h()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/k;->h:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/k;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    iput-boolean v1, p0, Lchat/ola/vn/m/k;->h:Z

    return-void
.end method

.method private j()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/m/k;->h:Z

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/k;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    iput-boolean v1, p0, Lchat/ola/vn/m/k;->h:Z

    return-void
.end method


# virtual methods
.method public b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    sput-object p0, Lchat/ola/vn/m/k;->b:Lchat/ola/vn/m/k;

    iget-object p1, p0, Lchat/ola/vn/m/k;->c:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance p1, Lchat/ola/vn/b/x;

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/x;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    iget-object p1, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/x;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/k;->c:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/m/k;->c:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    invoke-direct {p0}, Lchat/ola/vn/m/k;->d()V

    return-void
.end method

.method public c()I
    .locals 1

    const/16 v0, 0x9

    return v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 11

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0f0577

    const/4 v2, 0x1

    const v3, 0x7f0f043f

    const/4 v4, 0x0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/k;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->c()I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V

    return-void

    :sswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/j;

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    invoke-virtual {p0, v3}, Lchat/ola/vn/m/k;->getString(I)Ljava/lang/String;

    move-result-object v6

    const v0, 0x7f0f0230

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p1, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    aput-object v3, v2, v4

    invoke-virtual {p0, v0, v2}, Lchat/ola/vn/m/k;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    const v0, 0x7f0f04b7

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/k;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/k;->getString(I)Ljava/lang/String;

    move-result-object v9

    new-instance v10, Lchat/ola/vn/m/k$4;

    invoke-direct {v10, p0, p1}, Lchat/ola/vn/m/k$4;-><init>(Lchat/ola/vn/m/k;Lchat/ola/vn/entity/j;)V

    invoke-static/range {v5 .. v10}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :sswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/j;

    if-eqz p1, :cond_2

    iget-object v0, p1, Lchat/ola/vn/entity/j;->f:Ljava/lang/String;

    const-string v5, "3"

    invoke-virtual {v0, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p1, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_2

    new-instance v0, Lchat/ola/vn/message/f;

    iget-object v1, p1, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    invoke-direct {v0, v1, v4}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    iget-object v1, p1, Lchat/ola/vn/entity/j;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object p1, p1, Lchat/ola/vn/entity/j;->c:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    invoke-virtual {p1}, Lchat/ola/vn/b/x;->notifyDataSetChanged()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {p0, v3}, Lchat/ola/vn/m/k;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v5, 0x7f0f0170

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v6, p1, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    aput-object v6, v2, v4

    invoke-virtual {p0, v5, v2}, Lchat/ola/vn/m/k;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const v4, 0x7f0f0419

    invoke-virtual {p0, v4}, Lchat/ola/vn/m/k;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/k;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/m/k$3;

    invoke-direct {v6, p0, p1}, Lchat/ola/vn/m/k$3;-><init>(Lchat/ola/vn/m/k;Lchat/ola/vn/entity/j;)V

    move-object v1, v3

    move-object v3, v4

    move-object v4, v5

    move-object v5, v6

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    :sswitch_3
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f09027c -> :sswitch_3
        0x7f090379 -> :sswitch_2
        0x7f09037a -> :sswitch_1
        0x7f09039f -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const p2, 0x7f0b015f

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09039f

    :try_start_0
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0903a0

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    const p3, 0x7f080799

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setImageResource(I)V

    const p2, 0x7f0903a3

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    const p3, 0x7f0f057f

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(I)V

    const p2, 0x7f090309

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lchat/ola/vn/m/k;->c:Landroid/widget/ListView;

    const p2, 0x7f0903e9

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/k;->j:Landroid/view/View;

    const p2, 0x7f090375

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/k;->k:Landroid/view/View;

    const p2, 0x7f090380

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object p2, p0, Lchat/ola/vn/m/k;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object p2, p0, Lchat/ola/vn/m/k;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 p3, 0x1

    new-array p3, p3, [I

    const/4 v0, 0x0

    const v1, 0x7f06003d

    aput v1, p3, v0

    invoke-virtual {p2, p3}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object p2, p0, Lchat/ola/vn/m/k;->g:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance p3, Lchat/ola/vn/m/k$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/k$1;-><init>(Lchat/ola/vn/m/k;)V

    invoke-virtual {p2, p3}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p1
.end method

.method public onDetach()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/k;->b:Lchat/ola/vn/m/k;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 1
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
    iget-object p1, p0, Lchat/ola/vn/m/k;->d:Lchat/ola/vn/b/x;

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/x;->a(I)Lchat/ola/vn/entity/j;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/entity/j;->a:[Lchat/ola/vn/entity/d;

    if-eqz p1, :cond_3

    array-length p3, p1

    if-lez p3, :cond_3

    const/4 p3, 0x0

    aget-object p1, p1, p3

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object p4

    const-string p5, "viewme"

    invoke-static {p4, p5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p5

    if-eqz p5, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->c()Ljava/lang/String;

    move-result-object p2

    const-string p3, "comment"

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_0

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide p1

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    invoke-static {p3, p1, p2}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/content/Context;J)V

    return-void

    :cond_0
    const-string p3, "homepage"

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->b()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p2, p3, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :cond_1
    const-string p5, "viewmedia"

    invoke-static {p4, p5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p4

    if-eqz p4, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/entity/d;->e()Lchat/ola/vn/entity/i;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p4

    const/4 p5, 0x0

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v0, p3

    invoke-static {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a([Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-static {p4, p2, p5, p3, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/m/k;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method public onPause()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/k;->b:Lchat/ola/vn/m/k;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onPause()V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    add-int/2addr p2, p3

    const/4 p1, 0x1

    sub-int/2addr p4, p1

    if-lt p2, p4, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    iput-boolean p1, p0, Lchat/ola/vn/m/k;->i:Z

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    if-nez p2, :cond_0

    iget-boolean p1, p0, Lchat/ola/vn/m/k;->i:Z

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/m/k;->d()V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/m/k;->i:Z

    :cond_0
    return-void
.end method
