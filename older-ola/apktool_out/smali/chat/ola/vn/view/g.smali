.class public Lchat/ola/vn/view/g;
.super Lchat/ola/vn/view/d;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/s/b;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/g$e;,
        Lchat/ola/vn/view/g$b;,
        Lchat/ola/vn/view/g$a;,
        Lchat/ola/vn/view/g$d;,
        Lchat/ola/vn/view/g$c;
    }
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/view/g$e;

.field private b:Ljava/lang/String;

.field private c:Lit/sephiroth/android/library/widget/HListView;

.field private d:Lchat/ola/vn/view/g$c;

.field private e:Lchat/ola/vn/view/g$c;

.field private f:Landroid/view/View;

.field private g:Landroid/widget/ImageView;

.field private h:Landroid/widget/ImageView;

.field private i:I

.field private j:Ljava/lang/String;

.field private k:Z

.field private l:Z

.field private m:I

.field private n:I

.field private o:Z

.field private p:Landroid/view/animation/Animation;

.field private q:Landroid/view/animation/Animation;

.field private r:Lchat/ola/vn/view/g$d;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    invoke-direct {p0, p1}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/g;->b:Ljava/lang/String;

    const/4 v1, 0x1

    iput v1, p0, Lchat/ola/vn/view/g;->i:I

    iput-boolean v1, p0, Lchat/ola/vn/view/g;->k:Z

    iput-boolean v1, p0, Lchat/ola/vn/view/g;->l:Z

    const/4 v2, 0x0

    iput v2, p0, Lchat/ola/vn/view/g;->m:I

    iput v2, p0, Lchat/ola/vn/view/g;->n:I

    iput-boolean v1, p0, Lchat/ola/vn/view/g;->o:Z

    iput-object v0, p0, Lchat/ola/vn/view/g;->r:Lchat/ola/vn/view/g$d;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/g;->b:Ljava/lang/String;

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/view/g;->i:I

    iput-boolean v0, p0, Lchat/ola/vn/view/g;->k:Z

    iput-boolean v0, p0, Lchat/ola/vn/view/g;->l:Z

    const/4 v1, 0x0

    iput v1, p0, Lchat/ola/vn/view/g;->m:I

    iput v1, p0, Lchat/ola/vn/view/g;->n:I

    iput-boolean v0, p0, Lchat/ola/vn/view/g;->o:Z

    iput-object p2, p0, Lchat/ola/vn/view/g;->r:Lchat/ola/vn/view/g$d;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/g;->b:Ljava/lang/String;

    const/4 p3, 0x1

    iput p3, p0, Lchat/ola/vn/view/g;->i:I

    iput-boolean p3, p0, Lchat/ola/vn/view/g;->k:Z

    iput-boolean p3, p0, Lchat/ola/vn/view/g;->l:Z

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/view/g;->m:I

    iput v0, p0, Lchat/ola/vn/view/g;->n:I

    iput-boolean p3, p0, Lchat/ola/vn/view/g;->o:Z

    iput-object p2, p0, Lchat/ola/vn/view/g;->r:Lchat/ola/vn/view/g$d;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/g;Lchat/ola/vn/view/g$d;)Lchat/ola/vn/view/g$d;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g;->r:Lchat/ola/vn/view/g$d;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/view/g;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->b:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/view/g;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g;->j:Ljava/lang/String;

    return-object p1
.end method

.method private a(I)V
    .locals 5

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/g;->e:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->a()V

    const/4 p1, 0x0

    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    new-instance v2, Lchat/ola/vn/view/g$a;

    invoke-direct {v2, p0, v1}, Lchat/ola/vn/view/g$a;-><init>(Lchat/ola/vn/view/g;Lchat/ola/vn/view/g$1;)V

    new-array v3, v0, [Landroid/content/Context;

    invoke-virtual {p0}, Lchat/ola/vn/view/g;->getContext()Landroid/content/Context;

    move-result-object v4

    aput-object v4, v3, p1

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/g$a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-boolean v2, p0, Lchat/ola/vn/view/g;->o:Z

    if-eqz v2, :cond_0

    :try_start_1
    new-instance v2, Lchat/ola/vn/view/g$b;

    invoke-direct {v2, p0, v1}, Lchat/ola/vn/view/g$b;-><init>(Lchat/ola/vn/view/g;Lchat/ola/vn/view/g$1;)V

    new-array v0, v0, [Landroid/content/Context;

    invoke-virtual {p0}, Lchat/ola/vn/view/g;->getContext()Landroid/content/Context;

    move-result-object v1

    aput-object v1, v0, p1

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/g$b;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_0
    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 3

    const v0, 0x7f0b0137

    invoke-static {p1, v0, p0}, Lchat/ola/vn/view/g;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    const v0, 0x7f010024

    :try_start_0
    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/g;->p:Landroid/view/animation/Animation;

    iget-object v0, p0, Lchat/ola/vn/view/g;->p:Landroid/view/animation/Animation;

    const-wide/16 v1, 0x12c

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    const v0, 0x7f010021

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/g;->q:Landroid/view/animation/Animation;

    iget-object v0, p0, Lchat/ola/vn/view/g;->q:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    const v0, 0x7f0903cc

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/g;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/HListView;

    iput-object v0, p0, Lchat/ola/vn/view/g;->c:Lit/sephiroth/android/library/widget/HListView;

    const v0, 0x7f09030c

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/g;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/g;->f:Landroid/view/View;

    const v0, 0x7f090207

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/g;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/view/g;->g:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/view/g;->g:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0904b0

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/g;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/view/g;->h:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/view/g;->h:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/view/g;->h:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance v0, Lchat/ola/vn/view/g$c;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/view/g$c;-><init>(Lchat/ola/vn/view/g;Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/view/g;->d:Lchat/ola/vn/view/g$c;

    iget-object v0, p0, Lchat/ola/vn/view/g;->d:Lchat/ola/vn/view/g$c;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/g$c;->a(Lchat/ola/vn/b/j$a;)V

    new-instance v0, Lchat/ola/vn/view/g$c;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/view/g$c;-><init>(Lchat/ola/vn/view/g;Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/view/g;->e:Lchat/ola/vn/view/g$c;

    iget-object p1, p0, Lchat/ola/vn/view/g;->e:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/g$c;->a(Lchat/ola/vn/b/j$a;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/s/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/g;I)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->setTab(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/g;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->setProgressBarVisibility(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/view/g;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/g;->m:I

    return p0
.end method

.method static synthetic b(Lchat/ola/vn/view/g;I)I
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/g;->n:I

    return p1
.end method

.method private b()V
    .locals 5

    const-string v0, "OlaChat"

    const-string v1, "------LOAD CLOUD PHOTO------"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "upload:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0xa

    iget-object v3, p0, Lchat/ola/vn/view/g;->j:Ljava/lang/String;

    new-instance v4, Lchat/ola/vn/view/g$1;

    invoke-direct {v4, p0}, Lchat/ola/vn/view/g$1;-><init>(Lchat/ola/vn/view/g;)V

    invoke-static {v4}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;BLjava/lang/String;S)V

    :cond_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/view/g;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/g;->k:Z

    return p1
.end method

.method static synthetic c(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->p:Landroid/view/animation/Animation;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/view/g;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/g;->l:Z

    return p1
.end method

.method static synthetic d(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$d;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->r:Lchat/ola/vn/view/g$d;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->q:Landroid/view/animation/Animation;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/view/g;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->j:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic g(Lchat/ola/vn/view/g;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/view/g;->o:Z

    return p0
.end method

.method static synthetic h(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->d:Lchat/ola/vn/view/g$c;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->e:Lchat/ola/vn/view/g$c;

    return-object p0
.end method

.method static synthetic j(Lchat/ola/vn/view/g;)Lit/sephiroth/android/library/widget/HListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/g;->c:Lit/sephiroth/android/library/widget/HListView;

    return-object p0
.end method

.method private setProgressBarVisibility(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/g;->f:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/g;->f:Landroid/view/View;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method private setTab(I)V
    .locals 3

    iput p1, p0, Lchat/ola/vn/view/g;->i:I

    iget p1, p0, Lchat/ola/vn/view/g;->i:I

    const/4 v0, 0x0

    const/4 v1, 0x1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/view/g;->h:Landroid/widget/ImageView;

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/view/g;->c:Lit/sephiroth/android/library/widget/HListView;

    iget-object v2, p0, Lchat/ola/vn/view/g;->e:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1, v2}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/view/g;->e:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->c()Z

    move-result p1

    if-nez p1, :cond_0

    invoke-direct {p0, v1}, Lchat/ola/vn/view/g;->setProgressBarVisibility(Z)V

    invoke-direct {p0, v0}, Lchat/ola/vn/view/g;->a(I)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/view/g;->h:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setSelected(Z)V

    iget-object p1, p0, Lchat/ola/vn/view/g;->c:Lit/sephiroth/android/library/widget/HListView;

    iget-object v0, p0, Lchat/ola/vn/view/g;->d:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1, v0}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/view/g;->d:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->c()Z

    move-result p1

    if-nez p1, :cond_0

    invoke-direct {p0, v1}, Lchat/ola/vn/view/g;->setProgressBarVisibility(Z)V

    invoke-direct {p0}, Lchat/ola/vn/view/g;->b()V

    :cond_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public A(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/i;

    invoke-direct {v0}, Lchat/ola/vn/entity/i;-><init>()V

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/i;->a(S)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/i;->j(Ljava/lang/String;)V

    new-instance p1, Lchat/ola/vn/view/g$2;

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/view/g$2;-><init>(Lchat/ola/vn/view/g;Lchat/ola/vn/entity/i;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public B(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/view/g$3;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/view/g$3;-><init>(Lchat/ola/vn/view/g;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public B()Z
    .locals 1

    iget v0, p0, Lchat/ola/vn/view/g;->i:I

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lchat/ola/vn/view/g;->l:Z

    return v0

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/view/g;->k:Z

    return v0
.end method

.method public a_(I)V
    .locals 0

    iget p1, p0, Lchat/ola/vn/view/g;->i:I

    if-eqz p1, :cond_0

    iget p1, p0, Lchat/ola/vn/view/g;->n:I

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->a(I)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/view/g;->b()V

    return-void
.end method

.method public getOlaPhotoListener()Lchat/ola/vn/view/g$e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    return-object v0
.end method

.method public getSendButtonText()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/g;->b:Ljava/lang/String;

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090207

    if-eq p1, v0, :cond_2

    const v0, 0x7f0904b0

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget p1, p0, Lchat/ola/vn/view/g;->i:I

    if-nez p1, :cond_1

    const/4 p1, 0x1

    iput p1, p0, Lchat/ola/vn/view/g;->i:I

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/view/g;->i:I

    :goto_0
    iget p1, p0, Lchat/ola/vn/view/g;->i:I

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->setTab(I)V

    return-void

    :cond_2
    iget p1, p0, Lchat/ola/vn/view/g;->i:I

    if-nez p1, :cond_3

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-boolean v0, p0, Lchat/ola/vn/view/g;->o:Z

    iget-object v1, p0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    invoke-static {p1, v0, v1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Landroid/app/Activity;ZLchat/ola/vn/view/g$e;)V

    return-void

    :cond_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-boolean v0, p0, Lchat/ola/vn/view/g;->o:Z

    iget-object v1, p0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    invoke-static {p1, v0, v1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->b(Landroid/app/Activity;ZLchat/ola/vn/view/g$e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/view/d;->onSizeChanged(IIII)V

    iput p2, p0, Lchat/ola/vn/view/g;->m:I

    iget-object p1, p0, Lchat/ola/vn/view/g;->d:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->c()Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/g;->e:Lchat/ola/vn/view/g$c;

    invoke-virtual {p1}, Lchat/ola/vn/view/g$c;->c()Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->setProgressBarVisibility(Z)V

    iget p1, p0, Lchat/ola/vn/view/g;->i:I

    invoke-direct {p0, p1}, Lchat/ola/vn/view/g;->setTab(I)V

    :cond_0
    return-void
.end method

.method public setAllowVideo(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/g;->o:Z

    return-void
.end method

.method public setOlaPhotoListener(Lchat/ola/vn/view/g$e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    return-void
.end method

.method public setSendButtonText(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/g;->b:Ljava/lang/String;

    return-void
.end method
