.class public Lchat/ola/vn/me/c;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/support/v4/widget/DrawerLayout$DrawerListener;
.implements Landroid/view/View$OnFocusChangeListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/r/a/d;
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field private static E:Lchat/ola/vn/entity/n;

.field public static a:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/me/c;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private A:Lchat/ola/vn/b/q;

.field private B:Landroid/widget/TextView;

.field private C:Landroid/widget/TextView;

.field private D:Landroid/view/View;

.field private F:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private G:Z

.field private H:Ljava/lang/Runnable;

.field private I:Landroid/app/ProgressDialog;

.field private J:Ljava/lang/Runnable;

.field private b:Lchat/ola/vn/b/u;

.field private c:Lchat/ola/vn/view/OlaListView;

.field private d:Landroid/view/View;

.field private e:Landroid/view/animation/Animation;

.field private f:Landroid/view/animation/Animation;

.field private g:Landroid/view/animation/Animation;

.field private h:Landroid/view/animation/Animation;

.field private i:Landroid/widget/ImageView;

.field private j:Landroid/widget/ImageView;

.field private k:Landroid/widget/ImageView;

.field private l:Landroid/widget/ImageView;

.field private o:Landroid/support/v4/widget/DrawerLayout;

.field private p:Landroid/view/View;

.field private q:Landroid/view/View;

.field private r:Z

.field private s:Z

.field private t:Ljava/lang/String;

.field private u:Lchat/ola/vn/view/OlaListView;

.field private v:Lchat/ola/vn/b/an;

.field private w:Lchat/ola/vn/view/OlaListView;

.field private x:Lchat/ola/vn/me/b;

.field private y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private z:Landroid/os/Parcelable;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->r:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/me/c;->s:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/me/c;->t:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/me/c;->F:Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->G:Z

    iput-object v1, p0, Lchat/ola/vn/me/c;->H:Ljava/lang/Runnable;

    return-void
.end method

.method private A()V
    .locals 3

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->c()I

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->p:Landroid/view/View;

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->p:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getView()Landroid/view/View;

    move-result-object v0

    const v2, 0x7f0900a4

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->p:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lchat/ola/vn/me/c;Landroid/os/Parcelable;)Landroid/os/Parcelable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/me/c;)Lchat/ola/vn/me/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->x:Lchat/ola/vn/me/b;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/me/c;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c;->H:Ljava/lang/Runnable;

    return-object p1
.end method

.method private a(J)V
    .locals 3

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/me/c$14;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/me/c$14;-><init>(Lchat/ola/vn/me/c;J)V

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lchat/ola/vn/r/a/e;->a(I)V

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lchat/ola/vn/r/a/e;->a(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->c(JS)V

    :cond_0
    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/me/c;->e(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    sget-object v0, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    sget-object p1, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/me/c;

    invoke-virtual {p1}, Lchat/ola/vn/me/c;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->J()V

    :cond_0
    invoke-static {p0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    sget-object p1, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/me/c;

    invoke-direct {p1, p2}, Lchat/ola/vn/me/c;->f(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lchat/ola/vn/r/a/e;->a(I)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/e;->a(Z)V

    if-eqz p1, :cond_2

    new-instance v0, Lchat/ola/vn/entry/c/c;

    const-wide/16 v2, 0x0

    invoke-direct {v0, p2, v2, v3}, Lchat/ola/vn/entry/c/c;-><init>(Ljava/lang/String;J)V

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;S)V

    :cond_2
    :goto_0
    invoke-static {p0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    const/4 p0, 0x0

    sput-object p0, Lchat/ola/vn/me/c;->E:Lchat/ola/vn/entity/n;

    return-void

    :cond_3
    const-string p1, "my diary"

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-static {p0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_4
    const-string p1, "mariage diary"

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_5

    return-void

    :cond_5
    invoke-static {p0, p2}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    sput-object p3, Lchat/ola/vn/me/c;->E:Lchat/ola/vn/entity/n;

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p0, v0, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/c;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/c;->h(Ljava/lang/String;)V

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method private a(Ljava/lang/String;J)V
    .locals 8

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-nez v2, :cond_0

    const/4 v2, 0x0

    sput-object v2, Lchat/ola/vn/me/c;->E:Lchat/ola/vn/entity/n;

    :cond_0
    const-string v2, "my diary"

    invoke-static {v2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_1
    const-string v2, "mariage diary"

    invoke-static {v2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/me/c;->a(J)V

    return-void

    :cond_2
    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/me/c;->e(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_3
    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v2, :cond_6

    new-instance v3, Lchat/ola/vn/me/c$15;

    invoke-direct {v3, p0, p1, p2, p3}, Lchat/ola/vn/me/c$15;-><init>(Lchat/ola/vn/me/c;Ljava/lang/String;J)V

    cmp-long v4, p2, v0

    const/4 v5, 0x1

    const/4 v6, 0x0

    if-nez v4, :cond_4

    sget-object v4, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v4, v5}, Lchat/ola/vn/r/a/e;->a(Z)V

    iget-object v4, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    invoke-virtual {v4, v6}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_4
    sget-object v4, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v4, v6}, Lchat/ola/vn/r/a/e;->a(Z)V

    iget-object v4, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    const/16 v7, 0x8

    invoke-virtual {v4, v7}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iput-boolean v5, p0, Lchat/ola/vn/me/c;->r:Z

    cmp-long v4, p2, v0

    if-lez v4, :cond_5

    invoke-static {v3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v2, p1, p2, p3, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JS)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    invoke-virtual {p1, v6}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_5
    invoke-static {v3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p2

    invoke-virtual {v2, p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;S)V

    :goto_1
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, v6}, Lchat/ola/vn/r/a/e;->a(I)V

    :cond_6
    return-void
.end method

.method private a(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->J:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/me/c$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/c$3;-><init>(Lchat/ola/vn/me/c;)V

    iput-object v0, p0, Lchat/ola/vn/me/c;->J:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->J:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_2

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/me/c;->I:Landroid/app/ProgressDialog;

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f0f05ad

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/c;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f01d8

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/c;->I:Landroid/app/ProgressDialog;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/c;->I:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->show()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/me/c;->J:Ljava/lang/Runnable;

    const-wide/16 v0, 0x7530

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/me/c;->I:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->dismiss()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/c;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/c;->r:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/me/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/c;->x()V

    return-void
.end method

.method private b(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/c/t;->h(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/c;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/c;->s:Z

    return p1
.end method

.method static synthetic c(Lchat/ola/vn/me/c;)Lchat/ola/vn/b/u;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    return-object p0
.end method

.method public static c()Lchat/ola/vn/me/c;
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/me/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method static synthetic c(Lchat/ola/vn/me/c;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/c;->G:Z

    return p1
.end method

.method static synthetic d(Lchat/ola/vn/me/c;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/me/c;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/c;->a(Z)V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/me/c;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    return-object p0
.end method

.method private e(I)V
    .locals 3

    const/16 v0, 0x8

    if-lez p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object v1

    if-eqz v1, :cond_4

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    if-nez v1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/me/c;->g:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    const v1, 0x7f0f02c8

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->B:Landroid/widget/TextView;

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/me/c;->B:Landroid/widget/TextView;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->B:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/me/c;->B:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getVisibility()I

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/me/c;->h:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_3
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_4
    return-void
.end method

.method private static e(Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "tl"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "md"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "rs"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "me"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "lk"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "av"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p0, :cond_1

    :cond_0
    const/4 p0, 0x1

    return p0

    :catch_0
    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method static synthetic f(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    return-object p0
.end method

.method private f(Ljava/lang/String;)V
    .locals 2

    const-wide/16 v0, 0x0

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/me/c;->a(Ljava/lang/String;J)V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/me/c;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->H:Ljava/lang/Runnable;

    return-object p0
.end method

.method private h(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/me/c;->I:Landroid/app/ProgressDialog;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/c;->I:Landroid/app/ProgressDialog;

    invoke-virtual {p1}, Landroid/app/ProgressDialog;->isShowing()Z

    move-result p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    if-eqz p1, :cond_0

    return-void

    :catch_0
    move-object v0, p1

    :catch_1
    :cond_0
    const/4 p1, 0x0

    :try_start_2
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->x:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    :catch_2
    const/4 v1, 0x0

    :goto_0
    :try_start_3
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-static {v0}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x1

    invoke-direct {p0, v2}, Lchat/ola/vn/me/c;->a(Z)V

    if-eqz v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->t(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "name"

    aput-object v3, v2, p1

    new-instance p1, Lchat/ola/vn/me/c$19;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/c$19;-><init>(Lchat/ola/vn/me/c;)V

    invoke-virtual {v1, v0, v2, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/me/c$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$2;-><init>(Lchat/ola/vn/me/c;)V

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/i;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_2
    return-void
.end method

.method static synthetic h(Lchat/ola/vn/me/c;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/me/c;->G:Z

    return p0
.end method

.method static synthetic i(Lchat/ola/vn/me/c;)Landroid/support/v4/widget/SwipeRefreshLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->F:Landroid/support/v4/widget/SwipeRefreshLayout;

    return-object p0
.end method

.method private i(Ljava/lang/String;)V
    .locals 7

    const/4 v0, 0x1

    const v1, 0x7f080660

    const v2, 0x7f080650

    const v3, 0x7f080658

    const/4 v4, 0x0

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    const v5, 0x7f08065b

    invoke-virtual {p1, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    :goto_0
    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    :goto_1
    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    :goto_2
    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    return-void

    :cond_0
    const-string v5, "tl"

    invoke-static {p1, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    const v6, 0x7f08065a

    if-eqz v5, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    const v1, 0x7f080661

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, v6}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    goto :goto_1

    :cond_1
    const-string v5, "md"

    invoke-static {p1, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    const v3, 0x7f080659

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, v6}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    goto :goto_2

    :cond_2
    const-string v5, "av"

    invoke-static {p1, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    const v2, 0x7f080651

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, v6}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setSelected(Z)V

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    goto/16 :goto_0

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    invoke-virtual {p1, v6}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setSelected(Z)V

    goto :goto_3

    return-void
.end method

.method private j()V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    const/16 v2, 0x1f4

    invoke-virtual {v0, v1, v1, v2}, Lchat/ola/vn/view/OlaListView;->smoothScrollToPositionFromTop(III)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->smoothScrollToPosition(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic j(Lchat/ola/vn/me/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/c;->v()V

    return-void
.end method

.method static synthetic k(Lchat/ola/vn/me/c;)Lchat/ola/vn/view/OlaListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    return-object p0
.end method

.method static synthetic l(Lchat/ola/vn/me/c;)Landroid/os/Parcelable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    return-object p0
.end method

.method private v()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/me/c;->G:Z

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/c;->G:Z

    const/4 v1, 0x1

    xor-int/2addr v0, v1

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->G:Z

    iget-object v0, p0, Lchat/ola/vn/me/c;->F:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_1
    return-void
.end method

.method private x()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/c;->H:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c;->H:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/c;->G:Z

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_1
    iget-boolean v0, p0, Lchat/ola/vn/me/c;->G:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->G:Z

    iget-object v0, p0, Lchat/ola/vn/me/c;->F:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_2
    return-void
.end method

.method private y()V
    .locals 5

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b01bc

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f090294

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f090299

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f090553

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v1, v4}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    invoke-direct {p0, v2, v4}, Lchat/ola/vn/me/c;->b(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    sget-object v1, Lchat/ola/vn/c/x;->d:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    move-object v1, v4

    :cond_0
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    const v1, 0x7f0f05a2

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    :cond_1
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v2, Lchat/ola/vn/entity/af;

    invoke-direct {v2, v1, v4}, Lchat/ola/vn/entity/af;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/me/c;->u:Lchat/ola/vn/view/OlaListView;

    const/4 v3, 0x1

    invoke-virtual {v1, v0, v2, v3}, Lchat/ola/vn/view/OlaListView;->addHeaderView(Landroid/view/View;Ljava/lang/Object;Z)V

    return-void
.end method

.method private z()Z
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "RtlHardcoded"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->isDrawerOpen(I)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->isDrawerOpen(I)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    return v0

    :cond_1
    :goto_0
    const/4 v0, 0x1

    return v0
.end method


# virtual methods
.method public B()Z
    .locals 2

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/me/c;->s:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/c;->s:Z

    return v0
.end method

.method public C()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/c;->t:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "chat.ola.vn.fragment.MeViewFragment"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/c;->t:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->t:Ljava/lang/String;

    return-object v0
.end method

.method public D()V
    .locals 0

    return-void
.end method

.method public E()V
    .locals 4

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->r:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/me/c;->s:Z

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0}, Lchat/ola/vn/me/c;->A()V

    iget-object v2, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    sget-object v3, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v3}, Lchat/ola/vn/r/a/e;->m()Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_0
    const/16 v0, 0x8

    :goto_0
    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v1}, Lchat/ola/vn/me/c;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    iget-object v1, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    new-instance v1, Lchat/ola/vn/me/c$9;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$9;-><init>(Lchat/ola/vn/me/c;)V

    const-wide/16 v2, 0xfa

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/view/OlaListView;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public a(II)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/c;->A()V

    iget-object p1, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/e;->m()Z

    move-result p2

    if-eqz p2, :cond_0

    const/4 p2, 0x0

    goto :goto_0

    :cond_0
    const/16 p2, 0x8

    :goto_0
    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    return-void
.end method

.method protected a(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->a(Landroid/os/Bundle;)V

    if-eqz p1, :cond_0

    const-string v0, "BUNDLE_LIST_VIEW_PARCELABLE"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    :goto_0
    iput-object p1, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    return-void

    :cond_0
    const/4 p1, 0x0

    goto :goto_0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;S)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/a;->a(Lchat/ola/vn/entity/ag;S)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Lchat/ola/vn/entry/a;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/a;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    iget p2, p1, Lchat/ola/vn/entry/a;->c:I

    iget p1, p1, Lchat/ola/vn/entry/a;->d:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->r:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->s:Z

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0}, Lchat/ola/vn/me/c;->A()V

    invoke-direct {p0, v0}, Lchat/ola/vn/me/c;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    new-instance v0, Lchat/ola/vn/me/c$11;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/me/c$11;-><init>(Lchat/ola/vn/me/c;II)V

    const-wide/16 p1, 0xfa

    invoke-static {v0, p1, p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    invoke-static {}, Lchat/ola/vn/a;->a()Lchat/ola/vn/a;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/a;->a(Ljava/lang/String;)V

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

    iget-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    return-void
.end method

.method public a(Ljava/lang/Short;I)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/a;->a(Ljava/lang/Short;I)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/util/List;Ljava/util/List;)V
    .locals 1
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

    iput-boolean p1, p0, Lchat/ola/vn/me/c;->r:Z

    const/4 p2, 0x1

    iput-boolean p2, p0, Lchat/ola/vn/me/c;->s:Z

    iget-object p2, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->m()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    return-void
.end method

.method public a_(I)V
    .locals 5

    iget-boolean p1, p0, Lchat/ola/vn/me/c;->r:Z

    if-nez p1, :cond_2

    const-string p1, "my diary"

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    return-void

    :cond_0
    const-string p1, "mariage diary"

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x0

    const-wide/16 v1, 0x0

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->l()J

    move-result-wide v3

    cmp-long p1, v3, v1

    if-eqz p1, :cond_2

    invoke-direct {p0, v3, v4}, Lchat/ola/vn/me/c;->a(J)V

    goto :goto_0

    :cond_1
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->k()J

    move-result-wide v3

    cmp-long p1, v3, v1

    if-eqz p1, :cond_2

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1, v3, v4}, Lchat/ola/vn/me/c;->a(Ljava/lang/String;J)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void
.end method

.method public b(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object p1, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f010057

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/c;->e:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/me/c;->e:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x64

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v2, 0x7f010058

    invoke-static {p1, v2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/c;->f:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/me/c;->f:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v0, 0x7f010021

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/c;->g:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/me/c;->g:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x1f4

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const v2, 0x7f010024

    invoke-static {p1, v2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/c;->h:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/me/c;->h:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    new-instance p1, Lchat/ola/vn/b/u;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/u;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    iget-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/u;->a(Lchat/ola/vn/b/j$a;)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    new-instance v0, Lchat/ola/vn/me/c$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/c$4;-><init>(Lchat/ola/vn/me/c;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    new-instance v0, Lchat/ola/vn/me/c$5;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/c$5;-><init>(Lchat/ola/vn/me/c;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    iget-object v0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaListView;->setAdapter(Landroid/widget/ListAdapter;)V

    new-instance p1, Lchat/ola/vn/b/an;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/an;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/me/c;->v:Lchat/ola/vn/b/an;

    iget-object p1, p0, Lchat/ola/vn/me/c;->u:Lchat/ola/vn/view/OlaListView;

    iget-object v0, p0, Lchat/ola/vn/me/c;->v:Lchat/ola/vn/b/an;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaListView;->setAdapter(Landroid/widget/ListAdapter;)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->h()V

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

    return-void
.end method

.method public b_(Ljava/lang/String;)V
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {v0, v1, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->e()V

    return-void
.end method

.method public d()V
    .locals 6

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->c()I

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "mariage diary"

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    const-wide/16 v3, 0x0

    if-eqz v0, :cond_1

    new-instance v0, Lchat/ola/vn/entry/c/b;

    invoke-direct {v0, v3, v4}, Lchat/ola/vn/entry/c/b;-><init>(J)V

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    sget-object v5, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v5, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/entry/c/e;->a()S

    move-result v0

    invoke-virtual {v5, v3, v4, v0}, Lchat/ola/vn/network/OlaNetworkService;->c(JS)V

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, v2}, Lchat/ola/vn/r/a/e;->a(I)V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/e;->a(Z)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    const-string v0, "my diary"

    sget-object v5, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v5}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_2
    new-instance v0, Lchat/ola/vn/me/c$13;

    sget-object v5, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v5}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, p0, v5, v3, v4}, Lchat/ola/vn/me/c$13;-><init>(Lchat/ola/vn/me/c;Ljava/lang/String;J)V

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    sget-object v3, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v3, v2}, Lchat/ola/vn/r/a/e;->a(I)V

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v2, v1}, Lchat/ola/vn/r/a/e;->a(Z)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v1, :cond_3

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lchat/ola/vn/entry/c/e;->a()S

    move-result v0

    invoke-virtual {v1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;S)V

    :cond_3
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

    iget-object p1, p0, Lchat/ola/vn/me/c;->v:Lchat/ola/vn/b/an;

    invoke-virtual {p1}, Lchat/ola/vn/b/an;->notifyDataSetChanged()V

    return-void
.end method

.method public d_()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public e()V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "RtlHardcoded"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroid/support/v4/app/FragmentActivity;->getCurrentFocus()Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/EditText;

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public e(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->u()I

    move-result v0

    invoke-direct {p0, v0}, Lchat/ola/vn/me/c;->e(I)V

    :try_start_0
    sget-object v0, Lchat/ola/vn/c/x;->e:Ljava/lang/Short;

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/me/c$7;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$7;-><init>(Lchat/ola/vn/me/c;)V

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->d(S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->r:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/c;->s:Z

    invoke-direct {p0}, Lchat/ola/vn/me/c;->A()V

    invoke-direct {p0, p1}, Lchat/ola/vn/me/c;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/c$8;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/c$8;-><init>(Lchat/ola/vn/me/c;)V

    const-wide/16 v0, 0xfa

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    invoke-static {}, Lchat/ola/vn/a;->a()Lchat/ola/vn/a;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/a;->a(Ljava/lang/String;)V

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

.method public g(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public g_()Z
    .locals 4

    invoke-direct {p0}, Lchat/ola/vn/me/c;->z()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->e()V

    return v1

    :cond_0
    :try_start_0
    sget-object v0, Lchat/ola/vn/me/c;->E:Lchat/ola/vn/entity/n;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/n;->a(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v2, 0x0

    sput-object v2, Lchat/ola/vn/me/c;->E:Lchat/ola/vn/entity/n;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return v0

    :catch_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->c()I

    move-result v0

    const/4 v2, 0x0

    if-nez v0, :cond_3

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->d()Lchat/ola/vn/entry/a;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v3, v0, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    if-eqz v3, :cond_2

    sget-object v3, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v3, v2}, Lchat/ola/vn/r/a/e;->a(I)V

    sget-object v3, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v3, v0}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/entry/a;)V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, v2}, Lchat/ola/vn/r/a/e;->a(Z)V

    :cond_2
    return v1

    :cond_3
    return v2
.end method

.method public h()V
    .locals 4

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0}, Lchat/ola/vn/me/c;->A()V

    iget-object v1, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/e;->m()Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    :cond_0
    const/4 v2, 0x4

    :goto_0
    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v0}, Lchat/ola/vn/me/c;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/me/c;->A:Lchat/ola/vn/b/q;

    invoke-virtual {v0}, Lchat/ola/vn/b/q;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    iget-object v1, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaListView;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/c;->z:Landroid/os/Parcelable;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    new-instance v1, Lchat/ola/vn/me/c$6;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$6;-><init>(Lchat/ola/vn/me/c;)V

    const-wide/16 v2, 0xfa

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/view/OlaListView;->postDelayed(Ljava/lang/Runnable;J)Z

    invoke-static {}, Lchat/ola/vn/a;->a()Lchat/ola/vn/a;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/a;->a(Ljava/lang/String;)V

    return-void
.end method

.method public h_()Landroid/app/Dialog;
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0511

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f050f

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0510

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0623

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/me/c$12;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/me/c$12;-><init>(Lchat/ola/vn/me/c;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1
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
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    const-string v0, "my diary"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/16 p1, 0xa

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    goto :goto_0

    :cond_0
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    const-string v0, "mariage diary"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    const/16 p1, 0xb

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    goto :goto_0

    :cond_1
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_1

    :cond_2
    :goto_0
    move-object p1, v1

    :cond_3
    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-static {v0, p1, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->d()V

    return-void

    :sswitch_2
    invoke-direct {p0}, Lchat/ola/vn/me/c;->j()V

    return-void

    :sswitch_3
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    const v3, 0x7f0f009b

    const v4, 0x7f0f0222

    const v5, 0x7f0f06c2

    const v6, 0x7f0f0577

    new-instance v7, Lchat/ola/vn/me/c$1;

    invoke-direct {v7, p0}, Lchat/ola/vn/me/c$1;-><init>(Lchat/ola/vn/me/c;)V

    invoke-static/range {v2 .. v7}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :sswitch_4
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/me/OlaVisitorListActivity;->a(Landroid/content/Context;)V

    :goto_2
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_5
    invoke-virtual {p1}, Landroid/view/View;->isSelected()Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-direct {p0}, Lchat/ola/vn/me/c;->j()V

    goto :goto_2

    :cond_4
    const-string p1, "tl"

    invoke-direct {p0, p1}, Lchat/ola/vn/me/c;->f(Ljava/lang/String;)V

    goto :goto_2

    :sswitch_6
    invoke-virtual {p1}, Landroid/view/View;->isSelected()Z

    move-result p1

    if-eqz p1, :cond_5

    invoke-direct {p0}, Lchat/ola/vn/me/c;->j()V

    goto :goto_2

    :cond_5
    const-string p1, "md"

    invoke-direct {p0, p1}, Lchat/ola/vn/me/c;->f(Ljava/lang/String;)V

    goto :goto_2

    :sswitch_7
    invoke-virtual {p1}, Landroid/view/View;->isSelected()Z

    move-result p1

    if-eqz p1, :cond_6

    invoke-direct {p0}, Lchat/ola/vn/me/c;->j()V

    goto :goto_2

    :cond_6
    invoke-direct {p0, v1}, Lchat/ola/vn/me/c;->f(Ljava/lang/String;)V

    goto :goto_2

    :sswitch_8
    invoke-direct {p0, v1}, Lchat/ola/vn/me/c;->f(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f0900a4 -> :sswitch_8
        0x7f0900d2 -> :sswitch_7
        0x7f0900fc -> :sswitch_6
        0x7f090116 -> :sswitch_5
        0x7f09013d -> :sswitch_4
        0x7f090175 -> :sswitch_3
        0x7f0904a1 -> :sswitch_2
        0x7f0904e9 -> :sswitch_2
        0x7f090566 -> :sswitch_1
        0x7f090612 -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    sget-object p3, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p3, p0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/r/a/d;)V

    const/4 p3, 0x0

    const v0, 0x7f0b00f6

    invoke-virtual {p1, v0, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v0, 0x7f090338

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/support/v4/widget/DrawerLayout;

    iput-object p2, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    iget-object p2, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {p2, p0}, Landroid/support/v4/widget/DrawerLayout;->setDrawerListener(Landroid/support/v4/widget/DrawerLayout$DrawerListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    const v0, 0x7f0902d1

    invoke-virtual {p2, v0}, Landroid/support/v4/widget/DrawerLayout;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaListView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->u:Lchat/ola/vn/view/OlaListView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->u:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {p2, p0}, Lchat/ola/vn/view/OlaListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->o:Landroid/support/v4/widget/DrawerLayout;

    const v0, 0x7f090423

    invoke-virtual {p2, v0}, Landroid/support/v4/widget/DrawerLayout;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaListView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->w:Lchat/ola/vn/view/OlaListView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->w:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {p2, p0}, Lchat/ola/vn/view/OlaListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance p2, Lchat/ola/vn/me/b;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p2, v0}, Lchat/ola/vn/me/b;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/me/c;->x:Lchat/ola/vn/me/b;

    const p2, 0x7f0b00f5

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2

    iget-object v1, p0, Lchat/ola/vn/me/c;->w:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v1, p2}, Lchat/ola/vn/view/OlaListView;->addHeaderView(Landroid/view/View;)V

    const v1, 0x7f090452

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object v1, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const v1, 0x7f090175

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    sget-object p2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean p2, p2, Lchat/ola/vn/entity/ag;->x:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    const/4 p2, 0x0

    :goto_0
    if-eqz p2, :cond_0

    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const v1, 0x7f0f04df

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    goto :goto_1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const v1, 0x7f0f04db

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Lchat/ola/vn/me/c$16;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$16;-><init>(Lchat/ola/vn/me/c;)V

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->w:Lchat/ola/vn/view/OlaListView;

    iget-object v1, p0, Lchat/ola/vn/me/c;->x:Lchat/ola/vn/me/b;

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaListView;->setAdapter(Landroid/widget/ListAdapter;)V

    new-instance p2, Lchat/ola/vn/b/q;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {p2, v1}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, Lchat/ola/vn/me/c;->A:Lchat/ola/vn/b/q;

    iget-object p2, p0, Lchat/ola/vn/me/c;->A:Lchat/ola/vn/b/q;

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v1

    invoke-virtual {p2, v1}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->A:Lchat/ola/vn/b/q;

    new-instance v1, Lchat/ola/vn/b/q$a;

    iget-object v2, p0, Lchat/ola/vn/me/c;->A:Lchat/ola/vn/b/q;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v1, v2}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {p2, v1}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v1, p0, Lchat/ola/vn/me/c;->A:Lchat/ola/vn/b/q;

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Lchat/ola/vn/me/c$17;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$17;-><init>(Lchat/ola/vn/me/c;)V

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    :catch_1
    move-exception p2

    invoke-virtual {p2}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_2
    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f090612

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f090563

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->B:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f090566

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->C:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f09033c

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/me/c;->q:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f0904a2

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/me/c;->p:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f0900d2

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f090116

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f0900fc

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f09013d

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->i:Landroid/widget/ImageView;

    invoke-virtual {p2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->j:Landroid/widget/ImageView;

    invoke-virtual {p2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->k:Landroid/widget/ImageView;

    invoke-virtual {p2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->l:Landroid/widget/ImageView;

    invoke-virtual {p2, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f0904a1

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f090309

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaListView;

    iput-object p2, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    const v1, 0x7f0904ae

    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object p2, p0, Lchat/ola/vn/me/c;->F:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object p2, p0, Lchat/ola/vn/me/c;->F:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v1, v1, [I

    const v2, 0x7f06003d

    aput v2, v1, p3

    invoke-virtual {p2, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object p2, p0, Lchat/ola/vn/me/c;->F:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lchat/ola/vn/me/c$18;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/c$18;-><init>(Lchat/ola/vn/me/c;)V

    invoke-virtual {p2, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    const p2, 0x7f0b00d1

    :try_start_3
    invoke-virtual {p1, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    iget-object p2, p0, Lchat/ola/vn/me/c;->d:Landroid/view/View;

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaListView;->addFooterView(Landroid/view/View;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    iget-object p1, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    new-instance p2, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {p2, p3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object p1, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    invoke-direct {p0}, Lchat/ola/vn/me/c;->y()V

    iget-object p1, p0, Lchat/ola/vn/me/c;->D:Landroid/view/View;

    return-object p1
.end method

.method public onDestroy()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->e()V

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p0}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/r/a/d;)V

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDestroy()V

    return-void
.end method

.method public onDetach()V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->e()V

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/me/c;->a:Ljava/lang/ref/WeakReference;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    return-void
.end method

.method public onDrawerClosed(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onDrawerOpened(Landroid/view/View;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/c;->x:Lchat/ola/vn/me/b;

    invoke-virtual {p1}, Lchat/ola/vn/me/b;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 p1, 0x0

    :try_start_1
    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    move p1, v0

    :catch_1
    if-eqz p1, :cond_0

    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const v0, 0x7f0f04df

    :goto_0
    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setHint(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/c;->y:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    const v0, 0x7f0f04db

    goto :goto_0

    :catch_2
    return-void
.end method

.method public onDrawerSlide(Landroid/view/View;F)V
    .locals 0

    return-void
.end method

.method public onDrawerStateChanged(I)V
    .locals 0

    return-void
.end method

.method public onFocusChange(Landroid/view/View;Z)V
    .locals 0

    if-eqz p2, :cond_0

    check-cast p1, Landroid/widget/EditText;

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    return-void

    :cond_0
    check-cast p1, Landroid/widget/EditText;

    sget-object p2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/e;->h()Ljava/lang/CharSequence;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

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
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/me/c;->u:Lchat/ola/vn/view/OlaListView;

    if-ne p1, p2, :cond_1

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/af;

    invoke-virtual {p1}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object p2

    const-string p3, "mariage diary"

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p2, :cond_0

    :try_start_1
    sget-object p2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object p2, p2, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f00a2

    const v2, 0x7f0f01a4

    const v3, 0x7f0f0506

    const v4, 0x7f0f0480

    new-instance v5, Lchat/ola/vn/me/c$10;

    invoke-direct {v5, p0}, Lchat/ola/vn/me/c$10;-><init>(Lchat/ola/vn/me/c;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->e()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :cond_0
    :try_start_2
    invoke-virtual {p1}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/me/c;->f(Ljava/lang/String;)V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/me/c;->e()V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/me/c;->w:Lchat/ola/vn/view/OlaListView;

    if-ne p1, p2, :cond_2

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/g;

    invoke-virtual {p0}, Lchat/ola/vn/me/c;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p3, p1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    :cond_2
    return-void
.end method

.method public onResume()V
    .locals 3

    invoke-super {p0}, Lchat/ola/vn/m/a;->onResume()V

    iget-object v0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/c;->b:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->u()I

    move-result v0

    invoke-direct {p0, v0}, Lchat/ola/vn/me/c;->e(I)V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->v()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_2

    :cond_1
    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->e(Ljava/lang/String;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaListView;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "BUNDLE_LIST_VIEW_PARCELABLE"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, p2}, Lchat/ola/vn/r/a/e;->b(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 1

    if-nez p2, :cond_1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/c;->c:Lchat/ola/vn/view/OlaListView;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p2

    :goto_0
    invoke-virtual {v0, p2}, Lchat/ola/vn/r/a/e;->c(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
