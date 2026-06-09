.class public Lchat/ola/vn/m/e;
.super Lchat/ola/vn/m/a;


# static fields
.field private static l:Ljava/lang/ref/WeakReference; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/m/e;",
            ">;"
        }
    .end annotation
.end field

.field private static o:Z = false

.field private static p:Landroid/os/CountDownTimer;


# instance fields
.field public a:Landroid/view/View;

.field private b:Lchat/ola/vn/m/p;

.field private c:S

.field private d:Landroid/widget/TextView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/view/View;

.field private h:Landroid/view/View;

.field private i:Lcom/mg/ola/common/widget/OlaViewPager;

.field private j:Landroid/support/v4/app/FragmentPagerAdapter;

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/m/f;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lchat/ola/vn/m/e$1;

    const-wide/32 v1, 0x493e0

    invoke-direct {v0, v1, v2, v1, v2}, Lchat/ola/vn/m/e$1;-><init>(JJ)V

    sput-object v0, Lchat/ola/vn/m/e;->p:Landroid/os/CountDownTimer;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    const/4 v0, -0x1

    iput-short v0, p0, Lchat/ola/vn/m/e;->c:S

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/e;I)Lchat/ola/vn/m/p;
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/e;->c(I)Lchat/ola/vn/m/p;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/m/e;Lchat/ola/vn/m/p;)Lchat/ola/vn/m/p;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/m/e;S)S
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/m/e;->c:S

    return p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    sget-object p0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    if-eqz p0, :cond_1

    sget-object p0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {p0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_1

    sget-object p0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {p0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lchat/ola/vn/m/e;

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/e;

    iget-short v0, v0, Lchat/ola/vn/m/e;->c:S

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x0

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/m/e;->a(SLandroid/os/Bundle;)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    invoke-direct {p0, v1, v0}, Lchat/ola/vn/m/e;->a(SLandroid/os/Bundle;)V

    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/e;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/e;->j()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/e;SLandroid/os/Bundle;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/e;->a(SLandroid/os/Bundle;)V

    return-void
.end method

.method private a(SLandroid/os/Bundle;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0}, Lchat/ola/vn/m/p;->onPause()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-direct {p0, p1}, Lchat/ola/vn/m/e;->c(I)Lchat/ola/vn/m/p;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0}, Lchat/ola/vn/m/p;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p2}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0, p2}, Lchat/ola/vn/m/p;->setArguments(Landroid/os/Bundle;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_0
    :try_start_4
    iput-short p1, p0, Lchat/ola/vn/m/e;->c:S
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/e;)S
    .locals 0

    iget-short p0, p0, Lchat/ola/vn/m/e;->c:S

    return p0
.end method

.method public static final b(Landroid/content/Context;)V
    .locals 3

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    sget-object p0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {p0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lchat/ola/vn/m/e;

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    invoke-direct {p0, v1, v0}, Lchat/ola/vn/m/e;->a(SLandroid/os/Bundle;)V

    return-void

    :cond_1
    :goto_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v2, "EXTRA_REQUEST_SUBTAB_ID"

    invoke-virtual {v0, v2, v1}, Landroid/os/Bundle;->putShort(Ljava/lang/String;S)V

    invoke-static {p0, v1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;ILandroid/os/Bundle;)V

    return-void
.end method

.method static synthetic b(Z)Z
    .locals 0

    sput-boolean p0, Lchat/ola/vn/m/e;->o:Z

    return p0
.end method

.method public static c()Lchat/ola/vn/m/e;
    .locals 1

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/e;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method private c(I)Lchat/ola/vn/m/p;
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getChildFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "android:switcher:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->getId()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/support/v4/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/m/p;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method static synthetic c(Lchat/ola/vn/m/e;)Lchat/ola/vn/m/p;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/m/e;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/e;->k:Ljava/util/List;

    return-object p0
.end method

.method static synthetic h()Ljava/lang/ref/WeakReference;
    .locals 1

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    return-object v0
.end method

.method private j()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/m/e;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->d:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->C:I

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->e:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->D:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/m/e;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->d:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->D:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->e:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->C:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method protected a(Landroid/os/Bundle;)V
    .locals 4

    if-eqz p1, :cond_4

    :try_start_0
    const-string v0, "viewpagerState"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v1, "viewpagerState"

    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    const-string v0, "viewpagerState"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->remove(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "viewpagerState"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    const-string v0, "EXTRA_REQUEST_SUBTAB_ID"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    const-string v0, "EXTRA_REQUEST_SUBTAB_ID"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;S)S

    move-result v0

    const-string v2, "EXTRA_REQUEST_SUBTAB_ID"

    invoke-virtual {p1, v2}, Landroid/os/Bundle;->remove(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    :try_start_3
    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/FragmentActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    if-eqz v2, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-virtual {v2}, Landroid/support/v4/app/FragmentActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-string v3, "EXTRA_REQUEST_SUBTAB_ID"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    :cond_1
    :try_start_4
    const-string v0, "EXTRA_REQUEST_SUBTAB_ID"

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;S)S

    move-result v0
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :catch_1
    :cond_2
    :goto_0
    :try_start_5
    sget-object v2, Lchat/ola/vn/m/e;->p:Landroid/os/CountDownTimer;

    invoke-virtual {v2}, Landroid/os/CountDownTimer;->cancel()V

    sget-boolean v2, Lchat/ola/vn/m/e;->o:Z

    if-eqz v2, :cond_3

    sput-boolean v1, Lchat/ola/vn/m/e;->o:Z

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v2}, Lchat/ola/vn/message/g;->q()I

    move-result v2
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    if-lez v2, :cond_3

    const/4 v0, 0x0

    :catch_2
    :cond_3
    :try_start_6
    iget-object v1, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance v2, Lchat/ola/vn/m/e$2;

    invoke-direct {v2, p0, v0, p1}, Lchat/ola/vn/m/e$2;-><init>(Lchat/ola/vn/m/e;SLandroid/os/Bundle;)V

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->post(Ljava/lang/Runnable;)Z
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    :catch_3
    invoke-virtual {p0}, Lchat/ola/vn/m/e;->e()V

    :cond_4
    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;S)V
    .locals 1

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/a;->a(Lchat/ola/vn/entity/ag;S)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/m/p;->a(Lchat/ola/vn/entity/ag;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/Short;I)V
    .locals 1

    :try_start_0
    invoke-super {p0, p1, p2}, Lchat/ola/vn/m/a;->a(Ljava/lang/Short;I)V

    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/m/p;->a(Ljava/lang/Short;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/e;->h:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    :try_start_0
    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object p1, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/m/e;->k:Ljava/util/List;

    const/4 p1, 0x0

    :goto_0
    const/4 v0, 0x2

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/e;->k:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_0
    new-instance p1, Lchat/ola/vn/m/e$5;

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getChildFragmentManager()Landroid/support/v4/app/FragmentManager;

    move-result-object v0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/m/e$5;-><init>(Lchat/ola/vn/m/e;Landroid/support/v4/app/FragmentManager;)V

    iput-object p1, p0, Lchat/ola/vn/m/e;->j:Landroid/support/v4/app/FragmentPagerAdapter;

    iget-object p1, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object v0, p0, Lchat/ola/vn/m/e;->j:Landroid/support/v4/app/FragmentPagerAdapter;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/m/e;->c:S

    return v0
.end method

.method public e()V
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    const/4 v2, 0x4

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v1}, Lchat/ola/vn/m/p;->h()V

    iget-object v1, p0, Lchat/ola/vn/m/e;->a:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v3}, Lchat/ola/vn/m/p;->i()Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    const/4 v3, 0x4

    :goto_0
    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const v3, 0x7f0901ca

    invoke-virtual {v1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iget-object v3, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const v4, 0x7f0901cb

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ImageView;

    iget-object v4, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v5

    invoke-virtual {v4, v5}, Lchat/ola/vn/m/p;->b(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;

    move-result-object v4

    if-eqz v4, :cond_3

    iget-boolean v5, v4, Lchat/ola/vn/mediastore/a;->e:Z

    if-eqz v5, :cond_3

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v5, v4, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    iget-object v5, v4, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    iget v5, v4, Lchat/ola/vn/mediastore/a;->b:I

    if-lez v5, :cond_2

    iget v4, v4, Lchat/ola/vn/mediastore/a;->b:I

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_1

    :cond_2
    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_1

    :cond_3
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    :goto_1
    iget-object v1, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v1}, Lchat/ola/vn/m/p;->i()Z

    move-result v1

    if-nez v1, :cond_6

    iget-object v1, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v4

    invoke-virtual {v1, v4}, Lchat/ola/vn/m/p;->c(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;

    move-result-object v1

    if-eqz v1, :cond_5

    iget-boolean v4, v1, Lchat/ola/vn/mediastore/a;->e:Z

    if-eqz v4, :cond_5

    invoke-virtual {v3, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v2, v1, Lchat/ola/vn/mediastore/a;->c:Ljava/lang/String;

    invoke-virtual {v3, v2}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    iget-object v2, v1, Lchat/ola/vn/mediastore/a;->f:Landroid/view/View$OnClickListener;

    invoke-virtual {v3, v2}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    iget v2, v1, Lchat/ola/vn/mediastore/a;->b:I

    if-lez v2, :cond_4

    iget v1, v1, Lchat/ola/vn/mediastore/a;->b:I

    :goto_2
    invoke-virtual {v3, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_3

    :cond_4
    invoke-virtual {v3, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_3

    :cond_5
    invoke-virtual {v3, v2}, Landroid/widget/ImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :cond_6
    const v1, 0x7f08072c

    goto :goto_2

    :catch_0
    :goto_3
    :try_start_1
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->q()I

    move-result v1

    if-nez v1, :cond_7

    iget-object v0, p0, Lchat/ola/vn/m/e;->f:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_7
    iget-object v2, p0, Lchat/ola/vn/m/e;->f:Landroid/widget/TextView;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/m/e;->f:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public g_()Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0}, Lchat/ola/vn/m/p;->g_()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :catch_0
    :cond_0
    invoke-super {p0}, Lchat/ola/vn/m/a;->g_()Z

    move-result v0

    return v0
.end method

.method public h_()Landroid/app/Dialog;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0}, Lchat/ola/vn/m/p;->h_()Landroid/app/Dialog;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/e;->h_()Landroid/app/Dialog;

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    instance-of v0, v0, Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    check-cast v0, Landroid/view/View$OnClickListener;

    invoke-interface {v0, p1}, Landroid/view/View$OnClickListener;->onClick(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0901ca
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0b007c

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const p2, 0x7f0901b8

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/common/widget/OlaViewPager;

    iput-object p1, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object p1, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    const/16 p2, 0xa

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaViewPager;->setOffscreenPageLimit(I)V

    iget-object p1, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance p2, Lchat/ola/vn/m/e$3;

    invoke-direct {p2, p0}, Lchat/ola/vn/m/e$3;-><init>(Lchat/ola/vn/m/e;)V

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const p2, 0x7f09030e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/e;->h:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/e;->h:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const p2, 0x7f090122

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/m/e;->d:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const p2, 0x7f090123

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/m/e;->e:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const p2, 0x7f090595

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/m/e;->f:Landroid/widget/TextView;

    new-instance p1, Lchat/ola/vn/m/e$4;

    invoke-direct {p1, p0}, Lchat/ola/vn/m/e$4;-><init>(Lchat/ola/vn/m/e;)V

    iget-object p2, p0, Lchat/ola/vn/m/e;->d:Landroid/widget/TextView;

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/m/e;->e:Landroid/widget/TextView;

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const p2, 0x7f0901ca

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;

    const p2, 0x7f0901cb

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/e;->a:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/e;->a:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/e;->g:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    new-instance p1, Landroid/view/View;

    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    return-object p1
.end method

.method public onDestroy()V
    .locals 1

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    :cond_0
    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDestroy()V

    return-void
.end method

.method public onDetach()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->clear()V

    :cond_0
    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    sget-object v0, Lchat/ola/vn/m/e;->p:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->start()Landroid/os/CountDownTimer;

    return-void
.end method

.method public onPause()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/m/a;->onPause()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/e;->b:Lchat/ola/vn/m/p;

    invoke-virtual {v0}, Lchat/ola/vn/m/p;->onPause()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onResume()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/m/a;->onResume()V

    :try_start_0
    sget-object v0, Lchat/ola/vn/m/e;->p:Landroid/os/CountDownTimer;

    invoke-virtual {v0}, Landroid/os/CountDownTimer;->cancel()V

    sget-boolean v0, Lchat/ola/vn/m/e;->o:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/m/e;->o:Z

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1}, Lchat/ola/vn/message/g;->q()I

    move-result v1

    if-lez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/m/e;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p0}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lchat/ola/vn/m/e;->l:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 3

    if-eqz p1, :cond_0

    :try_start_0
    const-string v0, "EXTRA_REQUEST_SUBTAB_ID"

    iget-short v1, p0, Lchat/ola/vn/m/e;->c:S

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    int-to-short v1, v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putShort(Ljava/lang/String;S)V

    const-string v0, "viewpagerState"

    iget-object v1, p0, Lchat/ola/vn/m/e;->i:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :cond_0
    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/m/e;->getArguments()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/m/e;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/support/v4/app/Fragment;

    if-eqz v1, :cond_1

    invoke-virtual {v1, p1}, Landroid/support/v4/app/Fragment;->onSaveInstanceState(Landroid/os/Bundle;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    :cond_2
    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method
