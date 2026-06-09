.class Lcom/mg/ola/a/a/c/d;
.super Lcom/mg/ola/a/a/c/c;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/a/a/c/d$a;,
        Lcom/mg/ola/a/a/c/d$b;,
        Lcom/mg/ola/a/a/c/d$c;
    }
.end annotation


# instance fields
.field a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/c/d$b;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private c:J

.field private d:Z

.field private e:J

.field private f:Z

.field private g:Landroid/view/animation/Interpolator;

.field private h:Z

.field private i:Lcom/mg/ola/a/a/b/a$a;

.field private j:Lcom/mg/ola/a/a/c/d$a;

.field private k:Ljava/lang/Runnable;

.field private l:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lcom/mg/ola/a/a/b/a;",
            "Lcom/mg/ola/a/a/c/d$c;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/view/View;)V
    .locals 3

    invoke-direct {p0}, Lcom/mg/ola/a/a/c/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/d;->d:Z

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/mg/ola/a/a/c/d;->e:J

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/d;->f:Z

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/d;->h:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/c/d;->i:Lcom/mg/ola/a/a/b/a$a;

    new-instance v1, Lcom/mg/ola/a/a/c/d$a;

    invoke-direct {v1, p0, v0}, Lcom/mg/ola/a/a/c/d$a;-><init>(Lcom/mg/ola/a/a/c/d;Lcom/mg/ola/a/a/c/d$1;)V

    iput-object v1, p0, Lcom/mg/ola/a/a/c/d;->j:Lcom/mg/ola/a/a/c/d$a;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/d;->a:Ljava/util/ArrayList;

    new-instance v0, Lcom/mg/ola/a/a/c/d$1;

    invoke-direct {v0, p0}, Lcom/mg/ola/a/a/c/d$1;-><init>(Lcom/mg/ola/a/a/c/d;)V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/d;->k:Ljava/lang/Runnable;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/d;->l:Ljava/util/HashMap;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/d;->b:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method private a(I)F
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lcom/mg/ola/a/a/c/d;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    if-eqz v0, :cond_8

    const/4 v1, 0x4

    if-eq p1, v1, :cond_7

    const/16 v1, 0x8

    if-eq p1, v1, :cond_6

    const/16 v1, 0x10

    if-eq p1, v1, :cond_5

    const/16 v1, 0x20

    if-eq p1, v1, :cond_4

    const/16 v1, 0x40

    if-eq p1, v1, :cond_3

    const/16 v1, 0x80

    if-eq p1, v1, :cond_2

    const/16 v1, 0x100

    if-eq p1, v1, :cond_1

    const/16 v1, 0x200

    if-eq p1, v1, :cond_0

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-virtual {v0}, Landroid/view/View;->getTranslationY()F

    move-result p1

    return p1

    :pswitch_1
    invoke-virtual {v0}, Landroid/view/View;->getTranslationX()F

    move-result p1

    return p1

    :cond_0
    invoke-virtual {v0}, Landroid/view/View;->getAlpha()F

    move-result p1

    return p1

    :cond_1
    invoke-virtual {v0}, Landroid/view/View;->getY()F

    move-result p1

    return p1

    :cond_2
    invoke-virtual {v0}, Landroid/view/View;->getX()F

    move-result p1

    return p1

    :cond_3
    invoke-virtual {v0}, Landroid/view/View;->getRotationY()F

    move-result p1

    return p1

    :cond_4
    invoke-virtual {v0}, Landroid/view/View;->getRotationX()F

    move-result p1

    return p1

    :cond_5
    invoke-virtual {v0}, Landroid/view/View;->getRotation()F

    move-result p1

    return p1

    :cond_6
    invoke-virtual {v0}, Landroid/view/View;->getScaleY()F

    move-result p1

    return p1

    :cond_7
    invoke-virtual {v0}, Landroid/view/View;->getScaleX()F

    move-result p1

    return p1

    :cond_8
    :goto_0
    const/4 p1, 0x0

    return p1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lcom/mg/ola/a/a/c/d;Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/b/a$a;
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/c/d;->i:Lcom/mg/ola/a/a/b/a$a;

    return-object p1
.end method

.method private a()V
    .locals 6

    const/4 v0, 0x1

    new-array v0, v0, [F

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    aput v2, v0, v1

    invoke-static {v0}, Lcom/mg/ola/a/a/b/n;->b([F)Lcom/mg/ola/a/a/b/n;

    move-result-object v0

    iget-object v2, p0, Lcom/mg/ola/a/a/c/d;->a:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/ArrayList;

    iget-object v3, p0, Lcom/mg/ola/a/a/c/d;->a:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->clear()V

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_0
    if-ge v1, v3, :cond_0

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mg/ola/a/a/c/d$b;

    iget v5, v5, Lcom/mg/ola/a/a/c/d$b;->a:I

    or-int/2addr v4, v5

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/a/a/c/d;->l:Ljava/util/HashMap;

    new-instance v3, Lcom/mg/ola/a/a/c/d$c;

    invoke-direct {v3, v4, v2}, Lcom/mg/ola/a/a/c/d$c;-><init>(ILjava/util/ArrayList;)V

    invoke-virtual {v1, v0, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/mg/ola/a/a/c/d;->j:Lcom/mg/ola/a/a/c/d$a;

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/n$b;)V

    iget-object v1, p0, Lcom/mg/ola/a/a/c/d;->j:Lcom/mg/ola/a/a/c/d$a;

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/a$a;)V

    iget-boolean v1, p0, Lcom/mg/ola/a/a/c/d;->f:Z

    if-eqz v1, :cond_1

    iget-wide v1, p0, Lcom/mg/ola/a/a/c/d;->e:J

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/a/a/b/n;->e(J)V

    :cond_1
    iget-boolean v1, p0, Lcom/mg/ola/a/a/c/d;->d:Z

    if-eqz v1, :cond_2

    iget-wide v1, p0, Lcom/mg/ola/a/a/c/d;->c:J

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    :cond_2
    iget-boolean v1, p0, Lcom/mg/ola/a/a/c/d;->h:Z

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/mg/ola/a/a/c/d;->g:Landroid/view/animation/Interpolator;

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/n;->a(Landroid/view/animation/Interpolator;)V

    :cond_3
    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/n;->a()V

    return-void
.end method

.method private a(IF)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/c/d;->a(I)F

    move-result v0

    sub-float/2addr p2, v0

    invoke-direct {p0, p1, v0, p2}, Lcom/mg/ola/a/a/c/d;->a(IFF)V

    return-void
.end method

.method private a(IFF)V
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/a/a/c/d;->l:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->size()I

    move-result v0

    if-lez v0, :cond_2

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/mg/ola/a/a/c/d;->l:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/a;

    iget-object v3, p0, Lcom/mg/ola/a/a/c/d;->l:Ljava/util/HashMap;

    invoke-virtual {v3, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/c/d$c;

    invoke-virtual {v3, p1}, Lcom/mg/ola/a/a/c/d$c;->a(I)Z

    move-result v4

    if-eqz v4, :cond_0

    iget v3, v3, Lcom/mg/ola/a/a/c/d$c;->a:I

    if-nez v3, :cond_0

    move-object v0, v2

    :cond_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/a;->b()V

    :cond_2
    new-instance v0, Lcom/mg/ola/a/a/c/d$b;

    invoke-direct {v0, p1, p2, p3}, Lcom/mg/ola/a/a/c/d$b;-><init>(IFF)V

    iget-object p1, p0, Lcom/mg/ola/a/a/c/d;->a:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/mg/ola/a/a/c/d;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/View;

    if-eqz p1, :cond_3

    iget-object p2, p0, Lcom/mg/ola/a/a/c/d;->k:Ljava/lang/Runnable;

    invoke-virtual {p1, p2}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object p2, p0, Lcom/mg/ola/a/a/c/d;->k:Ljava/lang/Runnable;

    invoke-virtual {p1, p2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    :cond_3
    return-void
.end method

.method static synthetic a(Lcom/mg/ola/a/a/c/d;)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/c/d;->a()V

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/a/a/c/d;IF)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/a/a/c/d;->b(IF)V

    return-void
.end method

.method static synthetic b(Lcom/mg/ola/a/a/c/d;)Lcom/mg/ola/a/a/b/a$a;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/c/d;->i:Lcom/mg/ola/a/a/b/a$a;

    return-object p0
.end method

.method private b(IF)V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lcom/mg/ola/a/a/c/d;->b:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    if-eqz v0, :cond_8

    const/4 v1, 0x4

    if-eq p1, v1, :cond_7

    const/16 v1, 0x8

    if-eq p1, v1, :cond_6

    const/16 v1, 0x10

    if-eq p1, v1, :cond_5

    const/16 v1, 0x20

    if-eq p1, v1, :cond_4

    const/16 v1, 0x40

    if-eq p1, v1, :cond_3

    const/16 v1, 0x80

    if-eq p1, v1, :cond_2

    const/16 v1, 0x100

    if-eq p1, v1, :cond_1

    const/16 v1, 0x200

    if-eq p1, v1, :cond_0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-virtual {v0, p2}, Landroid/view/View;->setTranslationY(F)V

    return-void

    :pswitch_1
    invoke-virtual {v0, p2}, Landroid/view/View;->setTranslationX(F)V

    return-void

    :cond_0
    invoke-virtual {v0, p2}, Landroid/view/View;->setAlpha(F)V

    return-void

    :cond_1
    invoke-virtual {v0, p2}, Landroid/view/View;->setY(F)V

    return-void

    :cond_2
    invoke-virtual {v0, p2}, Landroid/view/View;->setX(F)V

    return-void

    :cond_3
    invoke-virtual {v0, p2}, Landroid/view/View;->setRotationY(F)V

    return-void

    :cond_4
    invoke-virtual {v0, p2}, Landroid/view/View;->setRotationX(F)V

    return-void

    :cond_5
    invoke-virtual {v0, p2}, Landroid/view/View;->setRotation(F)V

    return-void

    :cond_6
    invoke-virtual {v0, p2}, Landroid/view/View;->setScaleY(F)V

    return-void

    :cond_7
    invoke-virtual {v0, p2}, Landroid/view/View;->setScaleX(F)V

    :cond_8
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic c(Lcom/mg/ola/a/a/c/d;)Ljava/util/HashMap;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/c/d;->l:Ljava/util/HashMap;

    return-object p0
.end method

.method static synthetic d(Lcom/mg/ola/a/a/c/d;)Ljava/lang/ref/WeakReference;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/c/d;->b:Ljava/lang/ref/WeakReference;

    return-object p0
.end method


# virtual methods
.method public a(F)Lcom/mg/ola/a/a/c/c;
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lcom/mg/ola/a/a/c/d;->a(IF)V

    return-object p0
.end method

.method public a(J)Lcom/mg/ola/a/a/c/c;
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-gez v2, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Animators cannot have negative duration: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/d;->d:Z

    iput-wide p1, p0, Lcom/mg/ola/a/a/c/d;->c:J

    return-object p0
.end method

.method public a(Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/c/c;
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/c/d;->i:Lcom/mg/ola/a/a/b/a$a;

    return-object p0
.end method

.method public b(F)Lcom/mg/ola/a/a/c/c;
    .locals 1

    const/16 v0, 0x200

    invoke-direct {p0, v0, p1}, Lcom/mg/ola/a/a/c/d;->a(IF)V

    return-object p0
.end method
