.class public Lchat/ola/vn/view/i;
.super Lchat/ola/vn/view/d;

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/i$f;,
        Lchat/ola/vn/view/i$e;,
        Lchat/ola/vn/view/i$b;,
        Lchat/ola/vn/view/i$d;,
        Lchat/ola/vn/view/i$c;,
        Lchat/ola/vn/view/i$a;
    }
.end annotation


# static fields
.field private static b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/w;",
            ">;"
        }
    .end annotation
.end field

.field private static c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/v;",
            ">;"
        }
    .end annotation
.end field

.field private static d:Lchat/ola/vn/e/k;

.field private static e:Lchat/ola/vn/entity/v;


# instance fields
.field protected a:Lchat/ola/vn/view/i$e;

.field private f:Lit/sephiroth/android/library/widget/HListView;

.field private g:Lchat/ola/vn/view/i$a;

.field private h:Landroid/view/View;

.field private i:Landroid/support/v4/view/ViewPager;

.field private j:Lchat/ola/vn/view/i$f;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/view/i;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/view/i;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    invoke-direct {p0, p1}, Lchat/ola/vn/view/i;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entity/v;)Lchat/ola/vn/entity/v;
    .locals 0

    sput-object p0, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/view/i;)Lchat/ola/vn/view/i$a;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/i;->g:Lchat/ola/vn/view/i$a;

    return-object p0
.end method

.method private a(Landroid/content/Context;)V
    .locals 3

    const v0, 0x7f0b013b

    invoke-static {p1, v0, p0}, Lchat/ola/vn/view/i;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    const v0, 0x7f09049b

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/view/i;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/HListView;

    iput-object v0, p0, Lchat/ola/vn/view/i;->f:Lit/sephiroth/android/library/widget/HListView;

    const v0, 0x7f09049e

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/i;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/i;->h:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/view/i;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f0904a0

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/i;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/view/ViewPager;

    iput-object v0, p0, Lchat/ola/vn/view/i;->i:Landroid/support/v4/view/ViewPager;

    iget-object v0, p0, Lchat/ola/vn/view/i;->i:Landroid/support/v4/view/ViewPager;

    invoke-virtual {v0, p0}, Landroid/support/v4/view/ViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    new-instance v0, Lchat/ola/vn/view/i$a;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/view/i$a;-><init>(Lchat/ola/vn/view/i;Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/view/i;->g:Lchat/ola/vn/view/i$a;

    sget-object p1, Lchat/ola/vn/view/i;->c:Ljava/util/List;

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    sput-object p1, Lchat/ola/vn/view/i;->c:Ljava/util/List;

    new-instance p1, Lchat/ola/vn/entity/v;

    invoke-direct {p1}, Lchat/ola/vn/entity/v;-><init>()V

    sput-object p1, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    sget-object p1, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    const-string v0, "recent"

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/v;->a(Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/view/i;->c:Ljava/util/List;

    sget-object v0, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {}, Lchat/ola/vn/view/i;->d()V

    sget-object p1, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/v;->a(Ljava/util/List;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/i;->f:Lit/sephiroth/android/library/widget/HListView;

    iget-object v0, p0, Lchat/ola/vn/view/i;->g:Lchat/ola/vn/view/i$a;

    invoke-virtual {p1, v0}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V

    sget-object p1, Lchat/ola/vn/view/i;->c:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    const/4 v0, 0x1

    if-gt p1, v0, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/view/i$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/view/i$1;-><init>(Lchat/ola/vn/view/i;)V

    invoke-virtual {p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/p/m;)V

    :cond_1
    new-instance p1, Lchat/ola/vn/view/i$f;

    const/4 v1, 0x0

    invoke-direct {p1, p0, v1}, Lchat/ola/vn/view/i$f;-><init>(Lchat/ola/vn/view/i;Lchat/ola/vn/view/i$1;)V

    iput-object p1, p0, Lchat/ola/vn/view/i;->j:Lchat/ola/vn/view/i$f;

    iget-object p1, p0, Lchat/ola/vn/view/i;->i:Landroid/support/v4/view/ViewPager;

    iget-object v1, p0, Lchat/ola/vn/view/i;->j:Lchat/ola/vn/view/i$f;

    invoke-virtual {p1, v1}, Landroid/support/v4/view/ViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    sget-object p1, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object p1

    const-string v1, "recent"

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/view/i;->g:Lchat/ola/vn/view/i$a;

    invoke-virtual {p1}, Lchat/ola/vn/view/i$a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 p1, 0x0

    :try_start_1
    sget-object v1, Lchat/ola/vn/view/i;->c:Ljava/util/List;

    sget-object v2, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    invoke-interface {v1, v2}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move p1, v1

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/view/i;->i:Landroid/support/v4/view/ViewPager;

    invoke-virtual {v1, p1, v0}, Landroid/support/v4/view/ViewPager;->setCurrentItem(IZ)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method public static a(Lchat/ola/vn/entity/w;)V
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/view/i;->d()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entity/w;->d:J

    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    if-gez v0, :cond_2

    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_0

    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    sget-object v1, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_0
    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object p0, Lchat/ola/vn/view/i;->d:Lchat/ola/vn/e/k;

    if-nez p0, :cond_1

    new-instance p0, Lchat/ola/vn/e/k;

    invoke-direct {p0}, Lchat/ola/vn/e/k;-><init>()V

    sput-object p0, Lchat/ola/vn/view/i;->d:Lchat/ola/vn/e/k;

    :cond_1
    sget-object p0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    sget-object v0, Lchat/ola/vn/view/i;->d:Lchat/ola/vn/e/k;

    invoke-static {p0, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    goto :goto_0

    :cond_2
    sget-object p0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-interface {p0, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lchat/ola/vn/entity/w;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entity/w;->d:J

    :goto_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p0

    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-virtual {p0, v0}, Lchat/ola/vn/e;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/view/i;)Lchat/ola/vn/view/i$f;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/i;->j:Lchat/ola/vn/view/i$f;

    return-object p0
.end method

.method static synthetic b()Ljava/util/List;
    .locals 1

    sget-object v0, Lchat/ola/vn/view/i;->c:Ljava/util/List;

    return-object v0
.end method

.method private b(Lchat/ola/vn/entity/v;)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->c()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/i;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/view/i;->j:Lchat/ola/vn/view/i$f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/i$f;->a(Ljava/lang/String;)V

    return-void

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/view/i;->h:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/view/i$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/view/i$2;-><init>(Lchat/ola/vn/view/i;)V

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/v;Lchat/ola/vn/p/m;)V

    return-void
.end method

.method public static b(Lchat/ola/vn/entity/w;)Z
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/view/i;->d()V

    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    return p0

    :catch_0
    :cond_0
    const/4 p0, 0x0

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/view/i;)Landroid/support/v4/view/ViewPager;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/i;->i:Landroid/support/v4/view/ViewPager;

    return-object p0
.end method

.method static synthetic c()Lchat/ola/vn/entity/v;
    .locals 1

    sget-object v0, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    return-object v0
.end method

.method static synthetic d(Lchat/ola/vn/view/i;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/i;->h:Landroid/view/View;

    return-object p0
.end method

.method private static d()V
    .locals 2

    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x1e

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    sput-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->t()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    sget-object v1, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_0
    return-void
.end method


# virtual methods
.method public getOnStickerClickedListener()Lchat/ola/vn/view/i$e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/i;->a:Lchat/ola/vn/view/i$e;

    return-object v0
.end method

.method public onPageScrollStateChanged(I)V
    .locals 0

    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 0

    return-void
.end method

.method public onPageSelected(I)V
    .locals 2

    if-nez p1, :cond_1

    :try_start_0
    sget-object v0, Lchat/ola/vn/view/i;->d:Lchat/ola/vn/e/k;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/e/k;

    invoke-direct {v0}, Lchat/ola/vn/e/k;-><init>()V

    sput-object v0, Lchat/ola/vn/view/i;->d:Lchat/ola/vn/e/k;

    :cond_0
    sget-object v0, Lchat/ola/vn/view/i;->b:Ljava/util/List;

    sget-object v1, Lchat/ola/vn/view/i;->d:Lchat/ola/vn/e/k;

    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/view/i;->f:Lit/sephiroth/android/library/widget/HListView;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/HListView;->c(I)V

    sget-object v0, Lchat/ola/vn/view/i;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/v;

    sput-object p1, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    sget-object p1, Lchat/ola/vn/view/i;->e:Lchat/ola/vn/entity/v;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/i;->b(Lchat/ola/vn/entity/v;)V

    iget-object p1, p0, Lchat/ola/vn/view/i;->g:Lchat/ola/vn/view/i$a;

    invoke-virtual {p1}, Lchat/ola/vn/view/i$a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public setOnStickerClickedListener(Lchat/ola/vn/view/i$e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/i;->a:Lchat/ola/vn/view/i$e;

    return-void
.end method
