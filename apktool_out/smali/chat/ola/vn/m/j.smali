.class public Lchat/ola/vn/m/j;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/support/v4/widget/DrawerLayout$DrawerListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/m/j$b;,
        Lchat/ola/vn/m/j$a;
    }
.end annotation


# static fields
.field public static a:Lchat/ola/vn/entity/t; = null

.field public static b:Lchat/ola/vn/entity/t; = null

.field public static c:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation
.end field

.field public static d:Z = false

.field private static e:Z = false

.field private static f:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/m/j;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private A:Landroid/view/View;

.field private B:Landroid/view/View;

.field private g:Landroid/view/View;

.field private h:Landroid/view/View;

.field private i:Landroid/widget/EditText;

.field private j:Lcom/mg/ola/common/widget/OlaViewPager;

.field private k:Lchat/ola/vn/m/j$a;

.field private l:Landroid/support/v4/widget/DrawerLayout;

.field private o:Landroid/widget/ListView;

.field private p:Landroid/widget/ListView;

.field private q:Lchat/ola/vn/b/ag;

.field private r:Lchat/ola/vn/b/ai;

.field private s:Landroid/view/View;

.field private t:Landroid/view/View;

.field private u:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private v:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field private w:Landroid/view/animation/Animation;

.field private x:Landroid/view/animation/Animation;

.field private y:Lchat/ola/vn/m/c;

.field private z:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/j;)Lchat/ola/vn/b/ag;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->q:Lchat/ola/vn/b/ag;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/m/j;Lchat/ola/vn/m/c;)Lchat/ola/vn/m/c;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/m/j;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j;->z:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/m/j;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/j;->f(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, "rss://"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "rss://"

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lchat/ola/vn/m/j;->e:Z

    sget-object v1, Lchat/ola/vn/m/j;->f:Ljava/lang/ref/WeakReference;

    if-eqz v1, :cond_2

    sget-object v1, Lchat/ola/vn/m/j;->f:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    sget-object p0, Lchat/ola/vn/m/j;->f:Ljava/lang/ref/WeakReference;

    invoke-virtual {p0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lchat/ola/vn/m/j;

    new-instance v1, Lchat/ola/vn/entity/t;

    invoke-direct {v1, p1}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/m/j;->b(Lchat/ola/vn/entity/t;Z)V

    return-void

    :cond_2
    :goto_0
    new-instance v0, Lchat/ola/vn/entity/t;

    invoke-direct {v0, p1}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    sput-object v0, Lchat/ola/vn/m/j;->a:Lchat/ola/vn/entity/t;

    const/4 p1, 0x2

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;ILandroid/os/Bundle;)V

    return-void
.end method

.method private a(Lchat/ola/vn/entity/t;ZLjava/lang/Runnable;)V
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    sput-boolean v0, Lchat/ola/vn/m/j;->e:Z

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->e(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v1, :cond_2

    :try_start_1
    move-object p2, p3

    check-cast p2, Lchat/ola/vn/m/j$b;

    iget-object p2, p2, Lchat/ola/vn/m/j$b;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->w()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-interface {p3}, Ljava/lang/Runnable;->run()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_1
    return-void

    :cond_2
    if-nez p3, :cond_3

    :try_start_2
    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->b()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/t;->f(I)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/t;->g(I)V

    invoke-direct {p0, p1}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/entity/t;)V

    return-void

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/m/j;->g:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    if-eqz p2, :cond_4

    invoke-direct {p0}, Lchat/ola/vn/m/j;->h()V

    :cond_4
    new-instance p2, Lchat/ola/vn/m/j$2;

    const/4 v3, 0x0

    move-object v0, p2

    move-object v1, p0

    move-object v2, p1

    move-object v4, p1

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/m/j$2;-><init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;Ljava/lang/String;Lchat/ola/vn/entity/t;Ljava/lang/Runnable;)V

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p2

    invoke-virtual {p3, p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->r(Ljava/lang/String;S)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/entity/t;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;ZLjava/lang/Runnable;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;ZLjava/lang/Runnable;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/j;)Lchat/ola/vn/b/ai;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->r:Lchat/ola/vn/b/ai;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    return-object p0
.end method

.method public static c()Lchat/ola/vn/m/j;
    .locals 1

    sget-object v0, Lchat/ola/vn/m/j;->f:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/j;->f:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/j;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method static synthetic d(Lchat/ola/vn/m/j;)Lcom/mg/ola/common/widget/OlaViewPager;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/j$a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    return-object p0
.end method

.method private e(Lchat/ola/vn/entity/t;)V
    .locals 2

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->lastIndexOf(Ljava/lang/Object;)I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    invoke-virtual {v0}, Lchat/ola/vn/m/j$a;->notifyDataSetChanged()V

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :cond_0
    return-void

    :cond_1
    :goto_0
    sput-object p1, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    iget-object p1, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance v1, Lchat/ola/vn/m/j$3;

    invoke-direct {v1, p0, v0}, Lchat/ola/vn/m/j$3;-><init>(Lchat/ola/vn/m/j;I)V

    invoke-virtual {p1, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private f(Ljava/lang/String;)Lchat/ola/vn/entity/t;
    .locals 4

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    :goto_0
    if-ltz v0, :cond_2

    sget-object v2, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_1

    return-object v2

    :cond_1
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-object v1
.end method

.method static synthetic f(Lchat/ola/vn/m/j;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->z:Ljava/lang/String;

    return-object p0
.end method

.method private f(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->q(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "search/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "/"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method static synthetic g(Lchat/ola/vn/m/j;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->i:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic h(Lchat/ola/vn/m/j;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/j;->g:Landroid/view/View;

    return-object p0
.end method

.method private h()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    const/4 v2, 0x0

    invoke-interface {v0, v2, v1}, Ljava/util/List;->subList(II)Ljava/util/List;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    invoke-static {v0}, Lchat/ola/vn/m/j$a;->a(Lchat/ola/vn/m/j$a;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    sget-object v1, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-le v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    iget-object v1, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    invoke-static {v1}, Lchat/ola/vn/m/j$a;->a(Lchat/ola/vn/m/j$a;)Ljava/util/List;

    move-result-object v1

    sget-object v3, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    invoke-interface {v1, v2, v3}, Ljava/util/List;->subList(II)Ljava/util/List;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/m/j$a;->a(Lchat/ola/vn/m/j$a;Ljava/util/List;)Ljava/util/List;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    invoke-virtual {v0}, Lchat/ola/vn/m/j$a;->notifyDataSetChanged()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/t;Z)Landroid/app/Dialog;
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    if-eqz p2, :cond_0

    const v1, 0x7f0f04cd

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f04a6

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/j$12;

    invoke-direct {v2, p0, v0, p1, p2}, Lchat/ola/vn/m/j$12;-><init>(Lchat/ola/vn/m/j;Ljava/util/List;Lchat/ola/vn/entity/t;Z)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1
.end method

.method public a(Lchat/ola/vn/entity/t;)V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/m/j;->b(Lchat/ola/vn/entity/t;Z)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/t;Ljava/lang/Runnable;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/m/j$14;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1, p2}, Lchat/ola/vn/m/j$14;-><init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;Ljava/lang/String;Ljava/lang/Runnable;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {p2, p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->r(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object p1, Lchat/ola/vn/m/j;->f:Ljava/lang/ref/WeakReference;

    new-instance p1, Lchat/ola/vn/m/j$a;

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getChildFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/m/j$a;-><init>(Lchat/ola/vn/m/j;Landroid/support/v4/app/FragmentManager;)V

    iput-object p1, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    iget-object p1, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object v0, p0, Lchat/ola/vn/m/j;->k:Lchat/ola/vn/m/j$a;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    sget-object p1, Lchat/ola/vn/m/j;->a:Lchat/ola/vn/entity/t;

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/m/j;->a:Lchat/ola/vn/entity/t;

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1}, Lchat/ola/vn/m/j;->b(Lchat/ola/vn/entity/t;Z)V

    sput-object v0, Lchat/ola/vn/m/j;->a:Lchat/ola/vn/entity/t;

    goto :goto_0

    :cond_0
    sget-object p1, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-direct {p0, p1}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/entity/t;)V

    goto :goto_0

    :cond_1
    new-instance p1, Lchat/ola/vn/entity/t;

    check-cast v0, Ljava/lang/String;

    invoke-direct {p1, v0}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance v0, Lchat/ola/vn/m/j$13;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/j$13;-><init>(Lchat/ola/vn/m/j;)V

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->post(Ljava/lang/Runnable;)Z

    new-instance p1, Lchat/ola/vn/b/ag;

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/ag;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/j;->q:Lchat/ola/vn/b/ag;

    iget-object p1, p0, Lchat/ola/vn/m/j;->o:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/j;->q:Lchat/ola/vn/b/ag;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    new-instance p1, Lchat/ola/vn/b/ai;

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/ai;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/j;->r:Lchat/ola/vn/b/ai;

    iget-object p1, p0, Lchat/ola/vn/m/j;->p:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/j;->r:Lchat/ola/vn/b/ai;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/t;)V
    .locals 9

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    new-instance v8, Lchat/ola/vn/m/j$6;

    invoke-direct {v8, p0, p1}, Lchat/ola/vn/m/j$6;-><init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;)V

    const v1, 0x7f080797

    const v2, 0x7f0f040c

    const v3, 0x7f0f043e

    const v4, 0x7f0f040a

    const v5, 0x7f0f0480

    const v6, 0x84000

    const/4 v7, 0x0

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IIIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/p;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/p;->e(Ljava/lang/String;)V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/t;Z)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;ZLjava/lang/Runnable;)V

    return-void
.end method

.method public c(Lchat/ola/vn/entity/t;)V
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->p()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nrss://"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/j;->d(Lchat/ola/vn/entity/t;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v1, v2, v0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public d(Lchat/ola/vn/entity/t;)Ljava/lang/String;
    .locals 0

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->h()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public d()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/j;->h:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    invoke-virtual {v3}, Lchat/ola/vn/m/c;->i()Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    const/16 v3, 0x8

    :goto_0
    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    invoke-virtual {v0}, Lchat/ola/vn/m/c;->e()V

    iget-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/m/c;->a(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/mediastore/a;

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-virtual {v3, v4}, Lchat/ola/vn/mediastore/a;->a(Landroid/app/Activity;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_2
    sget-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_7

    sget-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    sget-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    const-string v3, "null"

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_4

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/m/j;->x:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/m/j;->x:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    :goto_3
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_5

    :cond_5
    :goto_4
    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eq v0, v2, :cond_6

    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/m/j;->w:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eq v0, v2, :cond_8

    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/m/j;->w:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_5

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    goto :goto_3

    :cond_8
    :goto_5
    sget-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    const v1, 0x7f0f05fa

    if-eqz v0, :cond_b

    sget-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "note/"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/m/j;->i:Landroid/widget/EditText;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f057b

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_6
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_7
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    return-void

    :cond_9
    sget-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "fic/"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/m/j;->i:Landroid/widget/EditText;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f04f0

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_6

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/m/j;->i:Landroid/widget/EditText;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0573

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_6

    :cond_b
    iget-object v0, p0, Lchat/ola/vn/m/j;->i:Landroid/widget/EditText;

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_7

    :catch_0
    return-void
.end method

.method public d_()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    invoke-virtual {v0}, Lchat/ola/vn/m/c;->d_()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public e()V
    .locals 4

    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    iget-object v1, p0, Lchat/ola/vn/m/j;->r:Lchat/ola/vn/b/ai;

    invoke-virtual {v0}, Lchat/ola/vn/r/b;->d()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/b/ai;->a(Ljava/util/List;)V

    iget-object v1, p0, Lchat/ola/vn/m/j;->r:Lchat/ola/vn/b/ai;

    invoke-virtual {v1}, Lchat/ola/vn/b/ai;->notifyDataSetChanged()V

    iget-object v1, p0, Lchat/ola/vn/m/j;->q:Lchat/ola/vn/b/ag;

    invoke-virtual {v0}, Lchat/ola/vn/r/b;->c()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/b/ag;->a(Ljava/util/List;)V

    iget-object v1, p0, Lchat/ola/vn/m/j;->q:Lchat/ola/vn/b/ag;

    invoke-virtual {v1}, Lchat/ola/vn/b/ag;->notifyDataSetChanged()V

    invoke-virtual {v0}, Lchat/ola/vn/r/b;->a()Z

    move-result v1

    const/4 v2, 0x0

    const/16 v3, 0x8

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/j;->t:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/j;->t:Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    invoke-virtual {v0}, Lchat/ola/vn/r/b;->b()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/j;->s:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/j;->s:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public e(Ljava/lang/String;)Z
    .locals 3

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/m/j;->f(Ljava/lang/String;)Lchat/ola/vn/entity/t;

    move-result-object p1

    if-eqz p1, :cond_0

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    sget-object v1, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    if-ne v0, v1, :cond_0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/entity/t;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public g_()Z
    .locals 3

    sget-boolean v0, Lchat/ola/vn/m/j;->e:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    sput-boolean v1, Lchat/ola/vn/m/j;->e:Z

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    invoke-virtual {v0}, Lchat/ola/vn/m/c;->g_()Z

    move-result v0

    if-eqz v0, :cond_1

    return v2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    iput-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    return v1

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    sub-int/2addr v0, v2

    invoke-virtual {v1, v0, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(IZ)V

    return v2
.end method

.method public onClick(Landroid/view/View;)V
    .locals 13

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0f0480

    const v1, 0x7f0f047e

    const v2, 0x7f0f00a2

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    iget-object p1, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    invoke-virtual {p1}, Lchat/ola/vn/m/c;->h_()Landroid/app/Dialog;

    return-void

    :sswitch_1
    iget-object p1, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v1, 0x1

    sub-int/2addr p1, v1

    invoke-virtual {v0, p1, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(IZ)V

    return-void

    :sswitch_2
    new-instance p1, Lchat/ola/vn/entity/t;

    const/4 v0, 0x0

    check-cast v0, Ljava/lang/String;

    invoke-direct {p1, v0}, Lchat/ola/vn/entity/t;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;)V

    return-void

    :sswitch_3
    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v3, 0x7f0f01e9

    invoke-virtual {p0, v3}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/m/j$5;

    invoke-direct {v6, p0}, Lchat/ola/vn/m/j$5;-><init>(Lchat/ola/vn/m/j;)V

    move-object v1, p1

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :sswitch_4
    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v7

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v8

    const p1, 0x7f0f01e8

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v11

    new-instance v12, Lchat/ola/vn/m/j$4;

    invoke-direct {v12, p0}, Lchat/ola/vn/m/j$4;-><init>(Lchat/ola/vn/m/j;)V

    invoke-static/range {v7 .. v12}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0900db -> :sswitch_4
        0x7f090118 -> :sswitch_3
        0x7f090368 -> :sswitch_2
        0x7f09039a -> :sswitch_1
        0x7f0903a1 -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2

    const p3, 0x7f0b0114

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09036a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/support/v4/widget/DrawerLayout;

    iput-object p2, p0, Lchat/ola/vn/m/j;->l:Landroid/support/v4/widget/DrawerLayout;

    iget-object p2, p0, Lchat/ola/vn/m/j;->l:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {p2, p0}, Landroid/support/v4/widget/DrawerLayout;->setDrawerListener(Landroid/support/v4/widget/DrawerLayout$DrawerListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/j;->l:Landroid/support/v4/widget/DrawerLayout;

    const p3, 0x7f0902d1

    invoke-virtual {p2, p3}, Landroid/support/v4/widget/DrawerLayout;->findViewById(I)Landroid/view/View;

    move-result-object p2

    const p3, 0x7f0902d0

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ListView;

    iput-object p3, p0, Lchat/ola/vn/m/j;->o:Landroid/widget/ListView;

    iget-object p3, p0, Lchat/ola/vn/m/j;->o:Landroid/widget/ListView;

    invoke-virtual {p3, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p3, p0, Lchat/ola/vn/m/j;->o:Landroid/widget/ListView;

    new-instance v0, Lchat/ola/vn/m/j$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/j$1;-><init>(Lchat/ola/vn/m/j;)V

    invoke-virtual {p3, v0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    const p3, 0x7f0903eb

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    iput-object p3, p0, Lchat/ola/vn/m/j;->s:Landroid/view/View;

    const p3, 0x7f090539

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object p3, p0, Lchat/ola/vn/m/j;->u:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object p3, p0, Lchat/ola/vn/m/j;->u:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/m/j$7;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/j$7;-><init>(Lchat/ola/vn/m/j;)V

    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    const p3, 0x7f0900db

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/j;->l:Landroid/support/v4/widget/DrawerLayout;

    const p3, 0x7f090423

    invoke-virtual {p2, p3}, Landroid/support/v4/widget/DrawerLayout;->findViewById(I)Landroid/view/View;

    move-result-object p2

    const p3, 0x7f090422

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/ListView;

    iput-object p3, p0, Lchat/ola/vn/m/j;->p:Landroid/widget/ListView;

    iget-object p3, p0, Lchat/ola/vn/m/j;->p:Landroid/widget/ListView;

    invoke-virtual {p3, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p3, p0, Lchat/ola/vn/m/j;->p:Landroid/widget/ListView;

    new-instance v0, Lchat/ola/vn/m/j$8;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/j$8;-><init>(Lchat/ola/vn/m/j;)V

    invoke-virtual {p3, v0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    const p3, 0x7f0903ed

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    iput-object p3, p0, Lchat/ola/vn/m/j;->t:Landroid/view/View;

    const p3, 0x7f090587

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object p3, p0, Lchat/ola/vn/m/j;->v:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object p3, p0, Lchat/ola/vn/m/j;->v:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/m/j$9;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/j$9;-><init>(Lchat/ola/vn/m/j;)V

    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    const p3, 0x7f090118

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0903ee

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/j;->g:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/m/j;->g:Landroid/view/View;

    const/16 p3, 0x8

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    const p2, 0x7f0903a1

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/j;->h:Landroid/view/View;

    const p2, 0x7f090369

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lcom/mg/ola/common/widget/OlaViewPager;

    iput-object p2, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object p2, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v0, 0x3

    invoke-virtual {p2, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setOffscreenPageLimit(I)V

    iget-object p2, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance v0, Lchat/ola/vn/m/j$10;

    invoke-direct {v0, p0}, Lchat/ola/vn/m/j$10;-><init>(Lchat/ola/vn/m/j;)V

    invoke-virtual {p2, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/j;->h:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/e;->r()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/j;->z:Ljava/lang/String;

    const p2, 0x7f09039a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/m/j;->A:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090368

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/j;->B:Landroid/view/View;

    invoke-virtual {p2, p3}, Landroid/view/View;->setVisibility(I)V

    const p2, 0x7f090451

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/EditText;

    iput-object p2, p0, Lchat/ola/vn/m/j;->i:Landroid/widget/EditText;

    iget-object p2, p0, Lchat/ola/vn/m/j;->i:Landroid/widget/EditText;

    new-instance p3, Lchat/ola/vn/m/j$11;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/j$11;-><init>(Lchat/ola/vn/m/j;)V

    invoke-virtual {p2, p3}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    const p3, 0x7f010024

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/j;->w:Landroid/view/animation/Animation;

    iget-object p2, p0, Lchat/ola/vn/m/j;->w:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x12c

    invoke-virtual {p2, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    const p3, 0x7f010021

    invoke-static {p2, p3}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/j;->x:Landroid/view/animation/Animation;

    iget-object p2, p0, Lchat/ola/vn/m/j;->x:Landroid/view/animation/Animation;

    invoke-virtual {p2, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    return-object p1
.end method

.method public onDetach()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/m/j;->e:Z

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/j;->f:Ljava/lang/ref/WeakReference;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    return-void
.end method

.method public onDrawerClosed(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/j;->u:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    invoke-virtual {p0}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/j;->v:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onDrawerOpened(Landroid/view/View;)V
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "RtlHardcoded"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/m/j;->l:Landroid/support/v4/widget/DrawerLayout;

    const/4 v0, 0x3

    invoke-virtual {p1, v0}, Landroid/support/v4/widget/DrawerLayout;->isDrawerVisible(I)Z

    move-result p1

    const/16 v0, 0x8

    const/4 v1, 0x0

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p1}, Lchat/ola/vn/r/b;->b()Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/j;->s:Landroid/view/View;

    :goto_0
    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/j;->s:Landroid/view/View;

    :goto_1
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    sget-object p1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {p1}, Lchat/ola/vn/r/b;->a()Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/j;->t:Landroid/view/View;

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/m/j;->t:Landroid/view/View;

    goto :goto_1

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

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "RtlHardcoded"
        }
    .end annotation

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
    iget-object p2, p0, Lchat/ola/vn/m/j;->v:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const-string p4, ""

    invoke-virtual {p2, p4}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p2, p0, Lchat/ola/vn/m/j;->u:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const-string p4, ""

    invoke-virtual {p2, p4}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    invoke-virtual {p0, p1}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;)V

    iget-object p1, p0, Lchat/ola/vn/m/j;->l:Landroid/support/v4/widget/DrawerLayout;

    const/4 p2, 0x3

    invoke-virtual {p1, p2}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V

    iget-object p1, p0, Lchat/ola/vn/m/j;->l:Landroid/support/v4/widget/DrawerLayout;

    const/4 p2, 0x5

    invoke-virtual {p1, p2}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onResume()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/m/a;->onResume()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/j;->y:Lchat/ola/vn/m/c;

    invoke-virtual {v0}, Lchat/ola/vn/m/c;->onResume()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    if-eqz p1, :cond_0

    const-string v0, "news_pager_state"

    iget-object v1, p0, Lchat/ola/vn/m/j;->j:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method
