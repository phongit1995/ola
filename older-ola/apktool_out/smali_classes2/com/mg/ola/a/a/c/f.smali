.class Lcom/mg/ola/a/a/c/f;
.super Lcom/mg/ola/a/a/c/c;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/a/a/c/f$a;,
        Lcom/mg/ola/a/a/c/f$b;,
        Lcom/mg/ola/a/a/c/f$c;
    }
.end annotation


# instance fields
.field a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/c/f$b;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Lcom/mg/ola/a/a/c/a;

.field private final c:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private d:J

.field private e:Z

.field private f:J

.field private g:Z

.field private h:Landroid/view/animation/Interpolator;

.field private i:Z

.field private j:Lcom/mg/ola/a/a/b/a$a;

.field private k:Lcom/mg/ola/a/a/c/f$a;

.field private l:Ljava/lang/Runnable;

.field private m:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lcom/mg/ola/a/a/b/a;",
            "Lcom/mg/ola/a/a/c/f$c;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Landroid/view/View;)V
    .locals 3

    invoke-direct {p0}, Lcom/mg/ola/a/a/c/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/f;->e:Z

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/mg/ola/a/a/c/f;->f:J

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/f;->g:Z

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/f;->i:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/c/f;->j:Lcom/mg/ola/a/a/b/a$a;

    new-instance v1, Lcom/mg/ola/a/a/c/f$a;

    invoke-direct {v1, p0, v0}, Lcom/mg/ola/a/a/c/f$a;-><init>(Lcom/mg/ola/a/a/c/f;Lcom/mg/ola/a/a/c/f$1;)V

    iput-object v1, p0, Lcom/mg/ola/a/a/c/f;->k:Lcom/mg/ola/a/a/c/f$a;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/f;->a:Ljava/util/ArrayList;

    new-instance v0, Lcom/mg/ola/a/a/c/f$1;

    invoke-direct {v0, p0}, Lcom/mg/ola/a/a/c/f$1;-><init>(Lcom/mg/ola/a/a/c/f;)V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/f;->l:Ljava/lang/Runnable;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/f;->m:Ljava/util/HashMap;

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/mg/ola/a/a/c/f;->c:Ljava/lang/ref/WeakReference;

    invoke-static {p1}, Lcom/mg/ola/a/a/c/a;->a(Landroid/view/View;)Lcom/mg/ola/a/a/c/a;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    return-void
.end method

.method private a(I)F
    .locals 1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_7

    const/16 v0, 0x8

    if-eq p1, v0, :cond_6

    const/16 v0, 0x10

    if-eq p1, v0, :cond_5

    const/16 v0, 0x20

    if-eq p1, v0, :cond_4

    const/16 v0, 0x40

    if-eq p1, v0, :cond_3

    const/16 v0, 0x80

    if-eq p1, v0, :cond_2

    const/16 v0, 0x100

    if-eq p1, v0, :cond_1

    const/16 v0, 0x200

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    const/4 p1, 0x0

    return p1

    :pswitch_0
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->l()F

    move-result p1

    return p1

    :pswitch_1
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->k()F

    move-result p1

    return p1

    :cond_0
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->a()F

    move-result p1

    return p1

    :cond_1
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->n()F

    move-result p1

    return p1

    :cond_2
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->m()F

    move-result p1

    return p1

    :cond_3
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->f()F

    move-result p1

    return p1

    :cond_4
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->e()F

    move-result p1

    return p1

    :cond_5
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->d()F

    move-result p1

    return p1

    :cond_6
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->h()F

    move-result p1

    return p1

    :cond_7
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->g()F

    move-result p1

    return p1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lcom/mg/ola/a/a/c/f;Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/b/a$a;
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/c/f;->j:Lcom/mg/ola/a/a/b/a$a;

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

    iget-object v2, p0, Lcom/mg/ola/a/a/c/f;->a:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/ArrayList;

    iget-object v3, p0, Lcom/mg/ola/a/a/c/f;->a:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->clear()V

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_0
    if-ge v1, v3, :cond_0

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mg/ola/a/a/c/f$b;

    iget v5, v5, Lcom/mg/ola/a/a/c/f$b;->a:I

    or-int/2addr v4, v5

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/a/a/c/f;->m:Ljava/util/HashMap;

    new-instance v3, Lcom/mg/ola/a/a/c/f$c;

    invoke-direct {v3, v4, v2}, Lcom/mg/ola/a/a/c/f$c;-><init>(ILjava/util/ArrayList;)V

    invoke-virtual {v1, v0, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/mg/ola/a/a/c/f;->k:Lcom/mg/ola/a/a/c/f$a;

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/n$b;)V

    iget-object v1, p0, Lcom/mg/ola/a/a/c/f;->k:Lcom/mg/ola/a/a/c/f$a;

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/a$a;)V

    iget-boolean v1, p0, Lcom/mg/ola/a/a/c/f;->g:Z

    if-eqz v1, :cond_1

    iget-wide v1, p0, Lcom/mg/ola/a/a/c/f;->f:J

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/a/a/b/n;->e(J)V

    :cond_1
    iget-boolean v1, p0, Lcom/mg/ola/a/a/c/f;->e:Z

    if-eqz v1, :cond_2

    iget-wide v1, p0, Lcom/mg/ola/a/a/c/f;->d:J

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    :cond_2
    iget-boolean v1, p0, Lcom/mg/ola/a/a/c/f;->i:Z

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/mg/ola/a/a/c/f;->h:Landroid/view/animation/Interpolator;

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/n;->a(Landroid/view/animation/Interpolator;)V

    :cond_3
    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/n;->a()V

    return-void
.end method

.method private a(IF)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/c/f;->a(I)F

    move-result v0

    sub-float/2addr p2, v0

    invoke-direct {p0, p1, v0, p2}, Lcom/mg/ola/a/a/c/f;->a(IFF)V

    return-void
.end method

.method private a(IFF)V
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f;->m:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->size()I

    move-result v0

    if-lez v0, :cond_2

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/mg/ola/a/a/c/f;->m:Ljava/util/HashMap;

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

    iget-object v3, p0, Lcom/mg/ola/a/a/c/f;->m:Ljava/util/HashMap;

    invoke-virtual {v3, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/c/f$c;

    invoke-virtual {v3, p1}, Lcom/mg/ola/a/a/c/f$c;->a(I)Z

    move-result v4

    if-eqz v4, :cond_0

    iget v3, v3, Lcom/mg/ola/a/a/c/f$c;->a:I

    if-nez v3, :cond_0

    move-object v0, v2

    :cond_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/a;->b()V

    :cond_2
    new-instance v0, Lcom/mg/ola/a/a/c/f$b;

    invoke-direct {v0, p1, p2, p3}, Lcom/mg/ola/a/a/c/f$b;-><init>(IFF)V

    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->a:Ljava/util/ArrayList;

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->c:Ljava/lang/ref/WeakReference;

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/View;

    if-eqz p1, :cond_3

    iget-object p2, p0, Lcom/mg/ola/a/a/c/f;->l:Ljava/lang/Runnable;

    invoke-virtual {p1, p2}, Landroid/view/View;->removeCallbacks(Ljava/lang/Runnable;)Z

    iget-object p2, p0, Lcom/mg/ola/a/a/c/f;->l:Ljava/lang/Runnable;

    invoke-virtual {p1, p2}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    :cond_3
    return-void
.end method

.method static synthetic a(Lcom/mg/ola/a/a/c/f;)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/c/f;->a()V

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/a/a/c/f;IF)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/a/a/c/f;->b(IF)V

    return-void
.end method

.method static synthetic b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/c/f;->j:Lcom/mg/ola/a/a/b/a$a;

    return-object p0
.end method

.method private b(IF)V
    .locals 1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_7

    const/16 v0, 0x8

    if-eq p1, v0, :cond_6

    const/16 v0, 0x10

    if-eq p1, v0, :cond_5

    const/16 v0, 0x20

    if-eq p1, v0, :cond_4

    const/16 v0, 0x40

    if-eq p1, v0, :cond_3

    const/16 v0, 0x80

    if-eq p1, v0, :cond_2

    const/16 v0, 0x100

    if-eq p1, v0, :cond_1

    const/16 v0, 0x200

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->j(F)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->i(F)V

    return-void

    :cond_0
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->a(F)V

    return-void

    :cond_1
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->l(F)V

    return-void

    :cond_2
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->k(F)V

    return-void

    :cond_3
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->f(F)V

    return-void

    :cond_4
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->e(F)V

    return-void

    :cond_5
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->d(F)V

    return-void

    :cond_6
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->h(F)V

    return-void

    :cond_7
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f;->b:Lcom/mg/ola/a/a/c/a;

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->g(F)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic c(Lcom/mg/ola/a/a/c/f;)Ljava/util/HashMap;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/c/f;->m:Ljava/util/HashMap;

    return-object p0
.end method

.method static synthetic d(Lcom/mg/ola/a/a/c/f;)Ljava/lang/ref/WeakReference;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/c/f;->c:Ljava/lang/ref/WeakReference;

    return-object p0
.end method


# virtual methods
.method public a(F)Lcom/mg/ola/a/a/c/c;
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0, p1}, Lcom/mg/ola/a/a/c/f;->a(IF)V

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

    iput-boolean v0, p0, Lcom/mg/ola/a/a/c/f;->e:Z

    iput-wide p1, p0, Lcom/mg/ola/a/a/c/f;->d:J

    return-object p0
.end method

.method public a(Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/c/c;
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/c/f;->j:Lcom/mg/ola/a/a/b/a$a;

    return-object p0
.end method

.method public b(F)Lcom/mg/ola/a/a/c/c;
    .locals 1

    const/16 v0, 0x200

    invoke-direct {p0, v0, p1}, Lcom/mg/ola/a/a/c/f;->a(IF)V

    return-object p0
.end method
