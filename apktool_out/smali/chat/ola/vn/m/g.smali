.class public Lchat/ola/vn/m/g;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;


# static fields
.field public static a:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private static b:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private static c:Z = false

.field private static d:Lchat/ola/vn/entity/e;

.field private static e:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/m/g;",
            ">;"
        }
    .end annotation
.end field

.field private static f:Ljava/lang/String;


# instance fields
.field private g:Landroid/widget/ListView;

.field private h:Lchat/ola/vn/b/am;

.field private i:Lchat/ola/vn/m/q;

.field private j:Landroid/view/View;

.field private k:Landroid/widget/TextView;

.field private l:Landroid/support/v4/widget/DrawerLayout;

.field private o:Landroid/view/View;

.field private p:Landroid/view/View;

.field private q:Landroid/view/View;

.field private r:Landroid/widget/ImageView;

.field private s:Landroid/widget/ImageView;

.field private t:Landroid/widget/ImageView;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    return-void
.end method

.method private A()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/g;->r:Landroid/widget/ImageView;

    const v1, 0x7f080656

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/m/g;->s:Landroid/widget/ImageView;

    const v1, 0x7f080654

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/m/g;->t:Landroid/widget/ImageView;

    const v1, 0x7f080652

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    sget-object v0, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "http"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    new-instance v1, Ljava/net/URL;

    invoke-direct {v1, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    :goto_0
    invoke-virtual {v1}, Ljava/net/URL;->getPath()Ljava/lang/String;

    move-result-object v1

    move-object v0, v1

    goto :goto_1

    :cond_1
    new-instance v1, Ljava/net/URL;

    const/4 v2, 0x1

    const/4 v3, 0x0

    invoke-static {v3, v0, v3, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/net/URL;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :goto_1
    if-eqz v0, :cond_2

    :try_start_2
    const-string v1, "/json"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "/json"

    const-string v2, ""

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    :cond_2
    invoke-virtual {p0, v0}, Lchat/ola/vn/m/g;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {p0, v2}, Lchat/ola/vn/m/g;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lchat/ola/vn/m/g;->g(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/g;->r:Landroid/widget/ImageView;

    const v1, 0x7f080657

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_3
    const-string v1, "/mall/new?p=0"

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/g;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/g;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lchat/ola/vn/m/g;->g(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-object v0, p0, Lchat/ola/vn/m/g;->s:Landroid/widget/ImageView;

    const v1, 0x7f080655

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_4
    const-string v1, "/mall/hot?p=0&t=2&hl=true"

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/g;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/g;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v1, v0}, Lchat/ola/vn/m/g;->g(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/m/g;->t:Landroid/widget/ImageView;

    const v1, 0x7f080653

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_5
    return-void
.end method

.method private B()V
    .locals 3

    sget-object v0, Lchat/ola/vn/m/g;->b:Ljava/util/List;

    if-nez v0, :cond_0

    const-string v0, "mall/tags"

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/m/g$5;

    invoke-direct {v2, p0}, Lchat/ola/vn/m/g$5;-><init>(Lchat/ola/vn/m/g;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/g;->h()V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    if-nez p1, :cond_0

    const/4 p1, 0x0

    :goto_0
    invoke-static {p0, p1}, Lchat/ola/vn/m/g;->b(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mall/watch?id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/g;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/g;->B()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/g;Lchat/ola/vn/entity/e;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/entity/e;)V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;Lchat/ola/vn/p/b;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/g;->o:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-virtual {v0, p2, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    :cond_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v0, Lchat/ola/vn/m/g$7;

    invoke-direct {v0, p0, p3, p4}, Lchat/ola/vn/m/g$7;-><init>(Lchat/ola/vn/m/g;Lchat/ola/vn/entity/e;Lchat/ola/vn/p/b;)V

    invoke-virtual {p2, p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/g;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/g;->o:Landroid/view/View;

    return-object p0
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/m/g;->c()Lchat/ola/vn/m/g;

    move-result-object v0

    if-nez v0, :cond_0

    sput-object p1, Lchat/ola/vn/m/g;->f:Ljava/lang/String;

    const/4 p1, 0x3

    invoke-static {p0, p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/m/g;->c()Lchat/ola/vn/m/g;

    move-result-object p0

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/m/g;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private b(Lchat/ola/vn/entity/e;)V
    .locals 6

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->p()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/g;->o:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/g;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    if-nez v0, :cond_2

    return-void

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mall_tag_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->getChildFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/g;->x()Lchat/ola/vn/m/q;

    move-result-object v5

    iput-object v5, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    iget-object v5, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    if-eqz v5, :cond_3

    iget-object v5, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v5}, Lchat/ola/vn/m/q;->c()V

    iget-object v5, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v5}, Lchat/ola/vn/m/q;->h()V

    iget-object v5, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v4, v5}, Landroid/support/v4/app/FragmentTransaction;->detach(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    :cond_3
    invoke-virtual {v3, v2}, Landroid/support/v4/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/m/q;

    if-eqz v5, :cond_4

    invoke-virtual {v5, p0}, Lchat/ola/vn/m/q;->a(Ljava/lang/Object;)V

    invoke-virtual {v5, p1}, Lchat/ola/vn/m/q;->a(Lchat/ola/vn/entity/e;)V

    invoke-virtual {v4, v5}, Landroid/support/v4/app/FragmentTransaction;->attach(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    invoke-virtual {v3, v2}, Landroid/support/v4/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/q;

    iput-object v0, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    iget-object v0, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v0, p1}, Lchat/ola/vn/m/q;->a(Lchat/ola/vn/entity/e;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    :catch_0
    :try_start_2
    iput-object v5, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    goto :goto_2

    :cond_4
    const/4 v3, 0x0

    packed-switch v1, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    const-class v1, Lchat/ola/vn/m/u;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    :goto_0
    move-object v3, v0

    check-cast v3, Lchat/ola/vn/m/q;

    goto :goto_1

    :pswitch_1
    const-class v1, Lchat/ola/vn/m/r;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    goto :goto_0

    :pswitch_2
    const-class v1, Lchat/ola/vn/m/t;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    goto :goto_0

    :pswitch_3
    const-class v1, Lchat/ola/vn/m/v;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    goto :goto_0

    :pswitch_4
    const-class v1, Lchat/ola/vn/m/w;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    goto :goto_0

    :pswitch_5
    const-class v1, Lchat/ola/vn/m/s;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    goto :goto_0

    :goto_1
    if-eqz v3, :cond_5

    invoke-virtual {v3, p1}, Lchat/ola/vn/m/q;->a(Lchat/ola/vn/entity/e;)V

    invoke-virtual {v3, p0}, Lchat/ola/vn/m/q;->a(Ljava/lang/Object;)V

    const v0, 0x7f09032d

    invoke-virtual {v4, v0, v3, v2}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    iput-object v3, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    :cond_5
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v0}, Lchat/ola/vn/m/q;->j()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_3

    :catchall_0
    move-exception p1

    goto :goto_4

    :catch_1
    move-exception v0

    :try_start_3
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :goto_3
    invoke-virtual {v4}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    sput-object p1, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->j()V

    invoke-direct {p0}, Lchat/ola/vn/m/g;->A()V

    return-void

    :goto_4
    invoke-virtual {v4}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    throw p1

    nop

    :pswitch_data_0
    .packed-switch -0x6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static c()Lchat/ola/vn/m/g;
    .locals 1

    sget-object v0, Lchat/ola/vn/m/g;->e:Ljava/lang/ref/WeakReference;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    sget-object v0, Lchat/ola/vn/m/g;->e:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/g;

    return-object v0
.end method

.method static synthetic c(Ljava/util/List;)Ljava/util/List;
    .locals 0

    sput-object p0, Lchat/ola/vn/m/g;->b:Ljava/util/List;

    return-object p0
.end method

.method private f(Ljava/lang/String;)Lchat/ola/vn/entity/e;
    .locals 3

    sget-object v0, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/m/g;->g(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object p1, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    return-object p1

    :cond_0
    sget-object v0, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2, p1}, Lchat/ola/vn/m/g;->g(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    return-object v1

    :cond_2
    const/4 p1, 0x0

    return-object p1
.end method

.method private g(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0

    if-nez p1, :cond_0

    :try_start_0
    const-string p1, "mall/"

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :cond_0
    :goto_0
    if-nez p2, :cond_1

    const-string p2, "mall/"

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/http/a;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p2}, Lchat/ola/vn/util/http/a;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    const/4 p1, 0x0

    return p1
.end method

.method static synthetic y()Lchat/ola/vn/entity/e;
    .locals 1

    sget-object v0, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    return-object v0
.end method

.method private z()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/g;->l:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->isDrawerOpen(I)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/g;->l:Landroid/support/v4/widget/DrawerLayout;

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
.method public a(Lchat/ola/vn/entity/e;)V
    .locals 3

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->e(Z)V

    iget-object v1, p0, Lchat/ola/vn/m/g;->o:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/m/g$6;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/m/g$6;-><init>(Lchat/ola/vn/m/g;Lchat/ola/vn/entity/e;)V

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    sput-boolean v0, Lchat/ola/vn/m/g;->c:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/m/g;->f(Ljava/lang/String;)Lchat/ola/vn/entity/e;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/g;->o:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->p()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/g;->o:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v1}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/entity/e;)V

    return-void

    :cond_1
    invoke-direct {p0, p1, p2, v1, p3}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    new-instance p1, Lchat/ola/vn/b/am;

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/am;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/g;->h:Lchat/ola/vn/b/am;

    iget-object p1, p0, Lchat/ola/vn/m/g;->g:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/g;->h:Lchat/ola/vn/b/am;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/m/g;->g:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    sget-object p1, Lchat/ola/vn/m/g;->f:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    sget-object p1, Lchat/ola/vn/m/g;->f:Ljava/lang/String;

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/m/g;->f(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lchat/ola/vn/m/g;->f:Ljava/lang/String;

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    invoke-direct {p0, p1}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/entity/e;)V

    return-void

    :cond_1
    invoke-virtual {p0, v0, v0}, Lchat/ola/vn/m/g;->f(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public d()I
    .locals 1

    const/4 v0, 0x3

    return v0
.end method

.method public d_()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v0}, Lchat/ola/vn/m/q;->d_()V

    return-void
.end method

.method public e(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-eqz p1, :cond_0

    const-string v0, "?"

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    if-ltz v0, :cond_0

    const/4 v1, 0x0

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    :cond_0
    return-object p1
.end method

.method public e()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/g;->l:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V

    iget-object v0, p0, Lchat/ola/vn/m/g;->l:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lchat/ola/vn/m/g;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/b;)V

    return-void
.end method

.method public g_()Z
    .locals 3

    sget-boolean v0, Lchat/ola/vn/m/g;->c:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/m/g;->c:Z

    return v0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/m/g;->z()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->e()V

    return v1

    :cond_1
    sget-object v0, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    sget-object v2, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-interface {v0, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/e;

    invoke-direct {p0, v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/entity/e;)V

    return v1

    :cond_2
    invoke-super {p0}, Lchat/ola/vn/m/a;->g_()Z

    move-result v0

    return v0
.end method

.method public h()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/g;->h:Lchat/ola/vn/b/am;

    sget-object v1, Lchat/ola/vn/m/g;->b:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/am;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/m/g;->h:Lchat/ola/vn/b/am;

    invoke-virtual {v0}, Lchat/ola/vn/b/am;->notifyDataSetChanged()V

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->x()Lchat/ola/vn/m/q;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/q;->v()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public j()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/g;->p:Landroid/view/View;

    sget-object v1, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    const/4 v2, -0x1

    const/4 v3, 0x0

    if-eq v1, v2, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    const/4 v1, 0x4

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/g;->j:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v1}, Lchat/ola/vn/m/q;->i()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_1

    :cond_1
    const/16 v3, 0x8

    :goto_1
    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/q;->a(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/mediastore/a;

    iget-object v2, p0, Lchat/ola/vn/m/g;->q:Landroid/view/View;

    invoke-virtual {v1, v2}, Lchat/ola/vn/mediastore/a;->a(Landroid/view/View;)V

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/m/g;->k:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v1}, Lchat/ola/vn/m/q;->e_()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09000d

    if-eq p1, v0, :cond_2

    const v0, 0x7f090011

    if-eq p1, v0, :cond_1

    const v0, 0x7f090013

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {p1}, Lchat/ola/vn/m/q;->h_()Landroid/app/Dialog;

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/g;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->d()I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->d(I)V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/m/g;->g_()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0b00e2

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090329

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/support/v4/widget/DrawerLayout;

    iput-object p2, p0, Lchat/ola/vn/m/g;->l:Landroid/support/v4/widget/DrawerLayout;

    iget-object p2, p0, Lchat/ola/vn/m/g;->l:Landroid/support/v4/widget/DrawerLayout;

    new-instance p3, Lchat/ola/vn/m/g$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/g$1;-><init>(Lchat/ola/vn/m/g;)V

    invoke-virtual {p2, p3}, Landroid/support/v4/widget/DrawerLayout;->setDrawerListener(Landroid/support/v4/widget/DrawerLayout$DrawerListener;)V

    const p2, 0x7f090324

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ListView;

    iput-object p2, p0, Lchat/ola/vn/m/g;->g:Landroid/widget/ListView;

    const p2, 0x7f09000e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/g;->q:Landroid/view/View;

    const p2, 0x7f09025b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/g;->p:Landroid/view/View;

    const p2, 0x7f090013

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/g;->j:Landroid/view/View;

    const p2, 0x7f09053a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/m/g;->k:Landroid/widget/TextView;

    const p2, 0x7f0900e3

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/m/g;->r:Landroid/widget/ImageView;

    const p2, 0x7f0900e2

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/m/g;->s:Landroid/widget/ImageView;

    const p2, 0x7f0900e1

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/m/g;->t:Landroid/widget/ImageView;

    const p2, 0x7f090011

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/g;->r:Landroid/widget/ImageView;

    new-instance p3, Lchat/ola/vn/m/g$2;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/g$2;-><init>(Lchat/ola/vn/m/g;)V

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/g;->s:Landroid/widget/ImageView;

    new-instance p3, Lchat/ola/vn/m/g$3;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/g$3;-><init>(Lchat/ola/vn/m/g;)V

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/g;->t:Landroid/widget/ImageView;

    new-instance p3, Lchat/ola/vn/m/g$4;

    invoke-direct {p3, p0}, Lchat/ola/vn/m/g$4;-><init>(Lchat/ola/vn/m/g;)V

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09032b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/m/g;->o:Landroid/view/View;

    const p2, 0x7f09000d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/g;->j:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object p1
.end method

.method public onDestroy()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/m/g;->c:Z

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/g;->e:Ljava/lang/ref/WeakReference;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDestroy()V

    return-void
.end method

.method public onDetach()V
    .locals 1

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/m/g;->c:Z

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    iget-object v0, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/g;->i:Lchat/ola/vn/m/q;

    invoke-virtual {v0}, Lchat/ola/vn/m/q;->c()V

    :cond_0
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
    invoke-virtual {p0}, Lchat/ola/vn/m/g;->e()V

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->t()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->J()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p2, p1}, Lchat/ola/vn/m/g;->f(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onResume()V
    .locals 1

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lchat/ola/vn/m/g;->e:Ljava/lang/ref/WeakReference;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onResume()V

    return-void
.end method

.method public v()V
    .locals 3

    new-instance v0, Lchat/ola/vn/entity/e;

    invoke-direct {v0}, Lchat/ola/vn/entity/e;-><init>()V

    const-string v1, "mall/search?q="

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->f(Ljava/lang/String;)V

    const v1, 0x7f0f05fa

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/g;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->h(Ljava/lang/String;)V

    const/4 v1, -0x5

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->f(I)V

    sget-object v1, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/m/g;->a:Ljava/util/List;

    sget-object v2, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    invoke-direct {p0, v0}, Lchat/ola/vn/m/g;->b(Lchat/ola/vn/entity/e;)V

    return-void
.end method

.method public x()Lchat/ola/vn/m/q;
    .locals 2

    sget-object v0, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "mall_tag_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lchat/ola/vn/m/g;->d:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->E()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/m/g;->getChildFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/support/v4/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/q;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
