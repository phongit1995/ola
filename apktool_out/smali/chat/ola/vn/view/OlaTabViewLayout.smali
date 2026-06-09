.class public Lchat/ola/vn/view/OlaTabViewLayout;
.super Landroid/widget/LinearLayout;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/OlaTabViewLayout$a;,
        Lchat/ola/vn/view/OlaTabViewLayout$b;,
        Lchat/ola/vn/view/OlaTabViewLayout$c;
    }
.end annotation


# instance fields
.field private a:Landroid/widget/FrameLayout;

.field private b:Landroid/widget/LinearLayout;

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/view/OlaTabViewLayout$c;",
            ">;"
        }
    .end annotation
.end field

.field private d:Landroid/support/v4/app/FragmentManager;

.field private e:Lchat/ola/vn/view/OlaTabViewLayout$c;

.field private f:Lchat/ola/vn/view/OlaTabViewLayout$a;

.field private g:Ljava/lang/String;

.field private h:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    const/4 p1, -0x2

    iput p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->h:I

    invoke-direct {p0}, Lchat/ola/vn/view/OlaTabViewLayout;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    const/4 p1, -0x2

    iput p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->h:I

    invoke-direct {p0}, Lchat/ola/vn/view/OlaTabViewLayout;->a()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    const/4 p1, -0x2

    iput p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->h:I

    invoke-direct {p0}, Lchat/ola/vn/view/OlaTabViewLayout;->a()V

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/FragmentTransaction;Landroid/os/Bundle;)Landroid/support/v4/app/FragmentTransaction;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    if-eq v0, p1, :cond_1

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-virtual {p2}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p2

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-direct {p0, v0, p2}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/FragmentTransaction;)V

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/OlaTabViewLayout;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/FragmentTransaction;Landroid/os/Bundle;)V

    iput-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    iget-object p3, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {p3}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p3

    if-eqz p3, :cond_1

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p3

    const/4 v0, 0x1

    invoke-virtual {p3, v0}, Landroid/support/v4/app/Fragment;->setMenuVisibility(Z)V

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/app/Fragment;->setUserVisibleHint(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return-object p2

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private a()V
    .locals 4

    new-instance v0, Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTabViewLayout;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->a:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->a:Landroid/widget/FrameLayout;

    const v1, 0x7f0904b7

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setId(I)V

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    const/4 v2, 0x0

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {v0, v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    const/4 v2, 0x1

    invoke-virtual {p0, v2}, Lchat/ola/vn/view/OlaTabViewLayout;->setOrientation(I)V

    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->a:Landroid/widget/FrameLayout;

    invoke-virtual {p0, v2, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTabViewLayout;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->b:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->b:Landroid/widget/LinearLayout;

    const v2, 0x7f0904b8

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setId(I)V

    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    iget v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->h:I

    invoke-direct {v0, v1, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    iget-object v1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->b:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaTabViewLayout$c;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    if-nez v0, :cond_0

    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "this tab host not yet setup by setUpTabHost(FragmentManager fm);"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    if-eqz p1, :cond_4

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->c(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/Class;

    move-result-object v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->d(Ljava/lang/String;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaTabViewLayout;->setUpTab(Lchat/ola/vn/view/OlaTabViewLayout$c;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    if-nez v0, :cond_3

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    :cond_3
    return-void

    :cond_4
    :goto_0
    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "if (StringUtils.isBlank(tag) || fragment == null )"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method private a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/FragmentTransaction;)V
    .locals 2

    if-eqz p1, :cond_4

    const/4 v0, 0x0

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v1

    if-nez v1, :cond_1

    invoke-static {p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/Fragment;

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->h(Lchat/ola/vn/view/OlaTabViewLayout$c;)Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/support/v4/app/FragmentTransaction;->hide(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    goto :goto_0

    :cond_2
    if-eqz v0, :cond_3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentManager;->saveFragmentInstanceState(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/Fragment$SavedState;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/Fragment$SavedState;)Landroid/support/v4/app/Fragment$SavedState;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/support/v4/app/FragmentTransaction;->remove(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    :goto_0
    :try_start_1
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p2

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->i(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/support/v4/app/Fragment;->onSaveInstanceState(Landroid/os/Bundle;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p2

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/support/v4/app/Fragment;->setMenuVisibility(Z)V

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/support/v4/app/Fragment;->setUserVisibleHint(Z)V

    :cond_4
    return-void
.end method

.method private b(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/FragmentTransaction;Landroid/os/Bundle;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/support/v4/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v1

    if-nez v1, :cond_1

    invoke-static {p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/Fragment;

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->h(Lchat/ola/vn/view/OlaTabViewLayout$c;)Z

    move-result v1

    if-eqz v1, :cond_2

    if-eqz v0, :cond_2

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/support/v4/app/FragmentTransaction;->show(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    return-void

    :cond_2
    if-eqz v0, :cond_3

    invoke-virtual {p2, v0}, Landroid/support/v4/app/FragmentTransaction;->remove(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    :cond_3
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->i(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/os/Bundle;

    move-result-object v0

    if-nez v0, :cond_4

    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    invoke-static {p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/os/Bundle;)Landroid/os/Bundle;

    :cond_4
    if-eqz p3, :cond_5

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->i(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v0, p3}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V

    :cond_5
    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTabViewLayout;->getContext()Landroid/content/Context;

    move-result-object p3

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->c(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->i(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/os/Bundle;

    move-result-object v1

    invoke-static {p3, v0, v1}, Landroid/support/v4/app/Fragment;->instantiate(Landroid/content/Context;Ljava/lang/String;Landroid/os/Bundle;)Landroid/support/v4/app/Fragment;

    move-result-object p3

    invoke-static {p1, p3}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/Fragment;

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p3

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->i(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/support/v4/app/Fragment;->setArguments(Landroid/os/Bundle;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->j(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment$SavedState;

    move-result-object p3

    if-eqz p3, :cond_6

    :try_start_1
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p3

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->j(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment$SavedState;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/support/v4/app/Fragment;->setInitialSavedState(Landroid/support/v4/app/Fragment$SavedState;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_6
    const p3, 0x7f0904b7

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p3, v0, p1}, Landroid/support/v4/app/FragmentTransaction;->add(ILandroid/support/v4/app/Fragment;Ljava/lang/String;)Landroid/support/v4/app/FragmentTransaction;

    return-void
.end method

.method private setUpTab(Lchat/ola/vn/view/OlaTabViewLayout$c;)V
    .locals 6

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->b:Landroid/widget/LinearLayout;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v1

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, 0x0

    const/4 v4, -0x1

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v2, v3, v4, v5}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/OlaTabViewLayout;->e(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    :cond_1
    return-void
.end method

.method private setUpWidgetSelected(Lchat/ola/vn/view/OlaTabViewLayout$c;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Z)V

    goto :goto_2

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v3

    if-eqz v3, :cond_2

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Z)V

    goto :goto_1

    :cond_3
    :goto_2
    if-eqz p1, :cond_5

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_4

    :goto_3
    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Z)V

    return-void

    :cond_4
    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object p1

    goto :goto_3

    :cond_5
    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Landroid/os/Bundle;)Landroid/support/v4/app/Fragment;
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "CommitTransaction"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    if-eqz p2, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    invoke-virtual {p1}, Landroid/support/v4/app/Fragment;->getArguments()Landroid/os/Bundle;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/os/Bundle;->putAll(Landroid/os/Bundle;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    return-object p1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-direct {p0, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->setUpWidgetSelected(Lchat/ola/vn/view/OlaTabViewLayout$c;)V

    const/4 p1, 0x0

    invoke-static {v1, p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/String;)Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->g(Lchat/ola/vn/view/OlaTabViewLayout$c;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object p1

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/String;)Ljava/lang/String;

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-virtual {p1}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    invoke-direct {p0, v1, p1, p2}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/FragmentTransaction;Landroid/os/Bundle;)Landroid/support/v4/app/FragmentTransaction;

    move-result-object p1

    if-eqz p1, :cond_4

    :try_start_1
    invoke-virtual {p1}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_4
    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    return-object p1

    :cond_5
    new-instance p2, Ljava/lang/RuntimeException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "this tag #"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " not yet added"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p2
.end method

.method public a(Ljava/lang/String;Ljava/lang/Class;Landroid/view/View;Z)Lchat/ola/vn/view/OlaTabViewLayout$c;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "*>;",
            "Landroid/view/View;",
            "Z)",
            "Lchat/ola/vn/view/OlaTabViewLayout$c;"
        }
    .end annotation

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move v4, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Ljava/lang/String;Ljava/lang/Class;Landroid/view/View;ZLchat/ola/vn/view/OlaTabViewLayout$b;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object p1

    return-object p1
.end method

.method public a(Ljava/lang/String;Ljava/lang/Class;Landroid/view/View;ZLchat/ola/vn/view/OlaTabViewLayout$b;)Lchat/ola/vn/view/OlaTabViewLayout$c;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/Class<",
            "*>;",
            "Landroid/view/View;",
            "Z",
            "Lchat/ola/vn/view/OlaTabViewLayout$b;",
            ")",
            "Lchat/ola/vn/view/OlaTabViewLayout$c;"
        }
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/view/OlaTabViewLayout;->d(Ljava/lang/String;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v0

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/OlaTabViewLayout$c;-><init>(Lchat/ola/vn/view/OlaTabViewLayout;)V

    invoke-virtual {v0, p5}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$b;)V

    invoke-static {v0, p2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/Class;)Ljava/lang/Class;

    invoke-static {v0, p4}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Z)Z

    invoke-static {v0, p1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Ljava/lang/String;)Ljava/lang/String;

    invoke-static {v0, p3}, Lchat/ola/vn/view/OlaTabViewLayout$c;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/view/View;)Landroid/view/View;

    invoke-direct {p0, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;)V

    :cond_1
    return-object v0

    :cond_2
    :goto_0
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "if (StringUtils.isBlank(tag) || fragment == null "

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-virtual {v0, p1}, Landroid/support/v4/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/support/v4/app/FragmentTransaction;->remove(Landroid/support/v4/app/Fragment;)Landroid/support/v4/app/FragmentTransaction;

    :try_start_0
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;)Landroid/view/View;
    .locals 4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p1, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {v2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object p1

    return-object p1

    :cond_2
    return-object v1
.end method

.method public c(Ljava/lang/String;)Landroid/support/v4/app/Fragment;
    .locals 4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p1, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-static {v2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    return-object p1

    :cond_2
    return-object v1
.end method

.method public d(Ljava/lang/String;)Lchat/ola/vn/view/OlaTabViewLayout$c;
    .locals 4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p1, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    return-object v2

    :cond_2
    return-object v1
.end method

.method public e(Ljava/lang/String;)Landroid/support/v4/app/Fragment;
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Ljava/lang/String;Landroid/os/Bundle;)Landroid/support/v4/app/Fragment;

    move-result-object p1

    return-object p1
.end method

.method public getCurrentFragmentTab()Landroid/support/v4/app/Fragment;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->e(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/support/v4/app/Fragment;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getTabTag()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->e:Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method protected onAttachedToWindow()V
    .locals 5

    invoke-super {p0}, Landroid/widget/LinearLayout;->onAttachedToWindow()V

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->beginTransaction()Landroid/support/v4/app/FragmentTransaction;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v2}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-direct {p0, v2, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;Landroid/support/v4/app/FragmentTransaction;)V

    goto :goto_0

    :cond_1
    :try_start_0
    invoke-virtual {v0}, Landroid/support/v4/app/FragmentTransaction;->commit()I

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    invoke-virtual {v0}, Landroid/support/v4/app/FragmentManager;->executePendingTransactions()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->g:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/OlaTabViewLayout;->e(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    :cond_2
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v2

    if-ne v2, p1, :cond_0

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->f(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_2

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    if-eqz v2, :cond_1

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->f(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lchat/ola/vn/view/OlaTabViewLayout;->d(Ljava/lang/String;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    iget-object v4, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v4

    invoke-interface {v3, v2, v4}, Lchat/ola/vn/view/OlaTabViewLayout$a;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;I)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_1

    return-void

    :catch_0
    :cond_1
    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->f(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {p0, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->e(Ljava/lang/String;)Landroid/support/v4/app/Fragment;

    goto :goto_0

    :cond_2
    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    iget-object v3, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v3, v1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v3

    invoke-interface {v2, v1, v3}, Lchat/ola/vn/view/OlaTabViewLayout$a;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;I)Z

    move-result v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    if-eqz v2, :cond_3

    return-void

    :catch_1
    :cond_3
    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->b(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_4
    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 0

    invoke-super {p0}, Landroid/widget/LinearLayout;->onDetachedFromWindow()V

    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_0
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaTabViewLayout$c;

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->d(Lchat/ola/vn/view/OlaTabViewLayout$c;)Landroid/view/View;

    move-result-object v2

    if-ne v2, p1, :cond_0

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->f(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    if-eqz v2, :cond_0

    invoke-static {v1}, Lchat/ola/vn/view/OlaTabViewLayout$c;->f(Lchat/ola/vn/view/OlaTabViewLayout$c;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lchat/ola/vn/view/OlaTabViewLayout;->d(Ljava/lang/String;)Lchat/ola/vn/view/OlaTabViewLayout$c;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    iget-object v3, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v3, v1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v3

    invoke-interface {v2, v1, v3}, Lchat/ola/vn/view/OlaTabViewLayout$a;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;I)Z

    move-result v1

    return v1

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    iget-object v3, p0, Lchat/ola/vn/view/OlaTabViewLayout;->c:Ljava/util/List;

    invoke-interface {v3, v1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v3

    invoke-interface {v2, v1, v3}, Lchat/ola/vn/view/OlaTabViewLayout$a;->a(Lchat/ola/vn/view/OlaTabViewLayout$c;I)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :cond_2
    const/4 p1, 0x0

    return p1
.end method

.method public setOnTabChangeListener(Lchat/ola/vn/view/OlaTabViewLayout$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->f:Lchat/ola/vn/view/OlaTabViewLayout$a;

    return-void
.end method

.method public setTabHostHeight(I)V
    .locals 2

    iget v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->h:I

    if-eq v0, p1, :cond_0

    iput p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->h:I

    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v0, -0x1

    iget v1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->h:I

    invoke-direct {p1, v0, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaTabViewLayout;->b:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    return-void
.end method

.method public setUpTabHost(Landroid/support/v4/app/FragmentManager;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaTabViewLayout;->d:Landroid/support/v4/app/FragmentManager;

    return-void
.end method
