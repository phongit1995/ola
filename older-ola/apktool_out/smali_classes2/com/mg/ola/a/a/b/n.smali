.class public Lcom/mg/ola/a/a/b/n;
.super Lcom/mg/ola/a/a/b/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/a/a/b/n$b;,
        Lcom/mg/ola/a/a/b/n$a;
    }
.end annotation


# static fields
.field private static h:Ljava/lang/ThreadLocal; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Lcom/mg/ola/a/a/b/n$a;",
            ">;"
        }
    .end annotation
.end field

.field private static final i:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/n;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final j:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/n;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final k:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/n;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final l:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/n;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final m:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/n;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final n:Landroid/view/animation/Interpolator;

.field private static final o:Lcom/mg/ola/a/a/b/m;

.field private static final p:Lcom/mg/ola/a/a/b/m;

.field private static z:J = 0xaL


# instance fields
.field private A:I

.field private B:I

.field private C:Landroid/view/animation/Interpolator;

.field private D:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/n$b;",
            ">;"
        }
    .end annotation
.end field

.field b:J

.field c:J

.field d:I

.field e:Z

.field f:[Lcom/mg/ola/a/a/b/l;

.field g:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lcom/mg/ola/a/a/b/l;",
            ">;"
        }
    .end annotation
.end field

.field private q:Z

.field private r:I

.field private s:F

.field private t:Z

.field private u:J

.field private v:Z

.field private w:Z

.field private x:J

.field private y:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->h:Ljava/lang/ThreadLocal;

    new-instance v0, Lcom/mg/ola/a/a/b/n$1;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/n$1;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->i:Ljava/lang/ThreadLocal;

    new-instance v0, Lcom/mg/ola/a/a/b/n$2;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/n$2;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->j:Ljava/lang/ThreadLocal;

    new-instance v0, Lcom/mg/ola/a/a/b/n$3;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/n$3;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->k:Ljava/lang/ThreadLocal;

    new-instance v0, Lcom/mg/ola/a/a/b/n$4;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/n$4;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->l:Ljava/lang/ThreadLocal;

    new-instance v0, Lcom/mg/ola/a/a/b/n$5;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/n$5;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->m:Ljava/lang/ThreadLocal;

    new-instance v0, Landroid/view/animation/AccelerateDecelerateInterpolator;

    invoke-direct {v0}, Landroid/view/animation/AccelerateDecelerateInterpolator;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->n:Landroid/view/animation/Interpolator;

    new-instance v0, Lcom/mg/ola/a/a/b/f;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/f;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->o:Lcom/mg/ola/a/a/b/m;

    new-instance v0, Lcom/mg/ola/a/a/b/d;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/d;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/n;->p:Lcom/mg/ola/a/a/b/m;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/a;-><init>()V

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/mg/ola/a/a/b/n;->c:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->q:Z

    iput v0, p0, Lcom/mg/ola/a/a/b/n;->r:I

    const/4 v1, 0x0

    iput v1, p0, Lcom/mg/ola/a/a/b/n;->s:F

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->t:Z

    iput v0, p0, Lcom/mg/ola/a/a/b/n;->d:I

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->v:Z

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->w:Z

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    const-wide/16 v1, 0x12c

    iput-wide v1, p0, Lcom/mg/ola/a/a/b/n;->x:J

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/mg/ola/a/a/b/n;->y:J

    iput v0, p0, Lcom/mg/ola/a/a/b/n;->A:I

    const/4 v0, 0x1

    iput v0, p0, Lcom/mg/ola/a/a/b/n;->B:I

    sget-object v0, Lcom/mg/ola/a/a/b/n;->n:Landroid/view/animation/Interpolator;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/n;->C:Landroid/view/animation/Interpolator;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/a/a/b/n;)J
    .locals 2

    iget-wide v0, p0, Lcom/mg/ola/a/a/b/n;->y:J

    return-wide v0
.end method

.method private a(Z)V
    .locals 6

    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance p1, Landroid/util/AndroidRuntimeException;

    const-string v0, "Animators may only be run on Looper threads"

    invoke-direct {p1, v0}, Landroid/util/AndroidRuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/n;->q:Z

    const/4 p1, 0x0

    iput p1, p0, Lcom/mg/ola/a/a/b/n;->r:I

    iput p1, p0, Lcom/mg/ola/a/a/b/n;->d:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->w:Z

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/n;->t:Z

    sget-object v1, Lcom/mg/ola/a/a/b/n;->j:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/ArrayList;

    invoke-virtual {v1, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-wide v1, p0, Lcom/mg/ola/a/a/b/n;->y:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-nez v5, :cond_1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/n;->k()J

    move-result-wide v1

    invoke-virtual {p0, v1, v2}, Lcom/mg/ola/a/a/b/n;->d(J)V

    iput p1, p0, Lcom/mg/ola/a/a/b/n;->d:I

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->v:Z

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v3, p0}, Lcom/mg/ola/a/a/b/a$a;->c(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    sget-object v0, Lcom/mg/ola/a/a/b/n;->h:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/n$a;

    if-nez v0, :cond_2

    new-instance v0, Lcom/mg/ola/a/a/b/n$a;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/mg/ola/a/a/b/n$a;-><init>(Lcom/mg/ola/a/a/b/n$1;)V

    sget-object v1, Lcom/mg/ola/a/a/b/n;->h:Ljava/lang/ThreadLocal;

    invoke-virtual {v1, v0}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    :cond_2
    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/n$a;->sendEmptyMessage(I)Z

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/a/a/b/n;J)Z
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/a/a/b/n;->b(J)Z

    move-result p0

    return p0
.end method

.method static synthetic a(Lcom/mg/ola/a/a/b/n;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/n;->v:Z

    return p1
.end method

.method public static varargs b([F)Lcom/mg/ola/a/a/b/n;
    .locals 1

    new-instance v0, Lcom/mg/ola/a/a/b/n;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/n;-><init>()V

    invoke-virtual {v0, p0}, Lcom/mg/ola/a/a/b/n;->a([F)V

    return-object v0
.end method

.method public static varargs b([I)Lcom/mg/ola/a/a/b/n;
    .locals 1

    new-instance v0, Lcom/mg/ola/a/a/b/n;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/n;-><init>()V

    invoke-virtual {v0, p0}, Lcom/mg/ola/a/a/b/n;->a([I)V

    return-object v0
.end method

.method static synthetic b(Lcom/mg/ola/a/a/b/n;)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/n;->t()V

    return-void
.end method

.method private b(J)Z
    .locals 8

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->t:Z

    const/4 v1, 0x1

    if-nez v0, :cond_0

    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/n;->t:Z

    iput-wide p1, p0, Lcom/mg/ola/a/a/b/n;->u:J

    goto :goto_0

    :cond_0
    iget-wide v2, p0, Lcom/mg/ola/a/a/b/n;->u:J

    sub-long v4, p1, v2

    iget-wide v2, p0, Lcom/mg/ola/a/a/b/n;->y:J

    cmp-long v0, v4, v2

    if-lez v0, :cond_1

    iget-wide v2, p0, Lcom/mg/ola/a/a/b/n;->y:J

    sub-long v6, v4, v2

    sub-long v2, p1, v6

    iput-wide v2, p0, Lcom/mg/ola/a/a/b/n;->b:J

    iput v1, p0, Lcom/mg/ola/a/a/b/n;->d:I

    return v1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return p1
.end method

.method static synthetic c(Lcom/mg/ola/a/a/b/n;)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/n;->i()V

    return-void
.end method

.method private i()V
    .locals 5

    sget-object v0, Lcom/mg/ola/a/a/b/n;->i:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    sget-object v0, Lcom/mg/ola/a/a/b/n;->j:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    sget-object v0, Lcom/mg/ola/a/a/b/n;->k:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    const/4 v0, 0x0

    iput v0, p0, Lcom/mg/ola/a/a/b/n;->d:I

    iget-boolean v1, p0, Lcom/mg/ola/a/a/b/n;->v:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v4, p0}, Lcom/mg/ola/a/a/b/a$a;->a(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->v:Z

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->w:Z

    return-void
.end method

.method static synthetic n()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Lcom/mg/ola/a/a/b/n;->i:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static synthetic o()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Lcom/mg/ola/a/a/b/n;->k:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static synthetic p()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Lcom/mg/ola/a/a/b/n;->j:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static synthetic q()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Lcom/mg/ola/a/a/b/n;->m:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static synthetic r()Ljava/lang/ThreadLocal;
    .locals 1

    sget-object v0, Lcom/mg/ola/a/a/b/n;->l:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static synthetic s()J
    .locals 2

    sget-wide v0, Lcom/mg/ola/a/a/b/n;->z:J

    return-wide v0
.end method

.method private t()V
    .locals 5

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/n;->h()V

    sget-object v0, Lcom/mg/ola/a/a/b/n;->i:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-wide v0, p0, Lcom/mg/ola/a/a/b/n;->y:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v3, p0}, Lcom/mg/ola/a/a/b/a$a;->c(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method public synthetic a(J)Lcom/mg/ola/a/a/b/a;
    .locals 0

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    move-result-object p1

    return-object p1
.end method

.method public a()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/mg/ola/a/a/b/n;->a(Z)V

    return-void
.end method

.method a(F)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->C:Landroid/view/animation/Interpolator;

    invoke-interface {v0, p1}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result p1

    iput p1, p0, Lcom/mg/ola/a/a/b/n;->s:F

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    iget-object v3, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v3, v3, v2

    invoke-virtual {v3, p1}, Lcom/mg/ola/a/a/b/l;->a(F)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    :goto_1
    if-ge v1, p1, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/n$b;

    invoke-interface {v0, p0}, Lcom/mg/ola/a/a/b/n$b;->a(Lcom/mg/ola/a/a/b/n;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_1
    return-void
.end method

.method public a(Landroid/view/animation/Interpolator;)V
    .locals 0

    if-eqz p1, :cond_0

    :goto_0
    iput-object p1, p0, Lcom/mg/ola/a/a/b/n;->C:Landroid/view/animation/Interpolator;

    return-void

    :cond_0
    new-instance p1, Landroid/view/animation/LinearInterpolator;

    invoke-direct {p1}, Landroid/view/animation/LinearInterpolator;-><init>()V

    goto :goto_0

    return-void
.end method

.method public a(Lcom/mg/ola/a/a/b/n$b;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public varargs a([F)V
    .locals 3

    if-eqz p1, :cond_3

    array-length v0, p1

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/l;->a([F)V

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v0, 0x1

    new-array v0, v0, [Lcom/mg/ola/a/a/b/l;

    const-string v2, ""

    invoke-static {v2, p1}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/l;

    move-result-object p1

    aput-object p1, v0, v1

    invoke-virtual {p0, v0}, Lcom/mg/ola/a/a/b/n;->a([Lcom/mg/ola/a/a/b/l;)V

    :goto_1
    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    :cond_3
    return-void
.end method

.method public varargs a([I)V
    .locals 3

    if-eqz p1, :cond_3

    array-length v0, p1

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v0, v0, v1

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/l;->a([I)V

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v0, 0x1

    new-array v0, v0, [Lcom/mg/ola/a/a/b/l;

    const-string v2, ""

    invoke-static {v2, p1}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/String;[I)Lcom/mg/ola/a/a/b/l;

    move-result-object p1

    aput-object p1, v0, v1

    invoke-virtual {p0, v0}, Lcom/mg/ola/a/a/b/n;->a([Lcom/mg/ola/a/a/b/l;)V

    :goto_1
    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    :cond_3
    return-void
.end method

.method public varargs a([Lcom/mg/ola/a/a/b/l;)V
    .locals 6

    array-length v0, p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1, v0}, Ljava/util/HashMap;-><init>(I)V

    iput-object v1, p0, Lcom/mg/ola/a/a/b/n;->g:Ljava/util/HashMap;

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    aget-object v3, p1, v2

    iget-object v4, p0, Lcom/mg/ola/a/a/b/n;->g:Ljava/util/HashMap;

    invoke-virtual {v3}, Lcom/mg/ola/a/a/b/l;->c()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    return-void
.end method

.method public b()V
    .locals 2

    iget v0, p0, Lcom/mg/ola/a/a/b/n;->d:I

    if-nez v0, :cond_0

    sget-object v0, Lcom/mg/ola/a/a/b/n;->j:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/mg/ola/a/a/b/n;->k:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_0
    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->v:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v1, p0}, Lcom/mg/ola/a/a/b/a$a;->b(Lcom/mg/ola/a/a/b/a;)V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lcom/mg/ola/a/a/b/n;->i()V

    :cond_2
    return-void
.end method

.method public c(J)Lcom/mg/ola/a/a/b/n;
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
    iput-wide p1, p0, Lcom/mg/ola/a/a/b/n;->x:J

    return-object p0
.end method

.method public c()V
    .locals 2

    sget-object v0, Lcom/mg/ola/a/a/b/n;->i:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lcom/mg/ola/a/a/b/n;->j:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->t:Z

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/n;->t()V

    goto :goto_0

    :cond_0
    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/n;->h()V

    :cond_1
    :goto_0
    iget v0, p0, Lcom/mg/ola/a/a/b/n;->A:I

    if-lez v0, :cond_2

    iget v0, p0, Lcom/mg/ola/a/a/b/n;->A:I

    const/4 v1, 0x1

    and-int/2addr v0, v1

    if-ne v0, v1, :cond_2

    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    const/high16 v0, 0x3f800000    # 1.0f

    :goto_1
    invoke-virtual {p0, v0}, Lcom/mg/ola/a/a/b/n;->a(F)V

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/n;->i()V

    return-void
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/n;->j()Lcom/mg/ola/a/a/b/n;

    move-result-object v0

    return-object v0
.end method

.method public d(J)V
    .locals 4

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/n;->h()V

    invoke-static {}, Landroid/view/animation/AnimationUtils;->currentAnimationTimeMillis()J

    move-result-wide v0

    iget v2, p0, Lcom/mg/ola/a/a/b/n;->d:I

    const/4 v3, 0x1

    if-eq v2, v3, :cond_0

    iput-wide p1, p0, Lcom/mg/ola/a/a/b/n;->c:J

    const/4 v2, 0x2

    iput v2, p0, Lcom/mg/ola/a/a/b/n;->d:I

    :cond_0
    const/4 v2, 0x0

    sub-long v2, v0, p1

    iput-wide v2, p0, Lcom/mg/ola/a/a/b/n;->b:J

    invoke-virtual {p0, v0, v1}, Lcom/mg/ola/a/a/b/n;->f(J)Z

    return-void
.end method

.method public d()Z
    .locals 2

    iget v0, p0, Lcom/mg/ola/a/a/b/n;->d:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->v:Z

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const/4 v1, 0x0

    :cond_1
    return v1
.end method

.method public e(J)V
    .locals 0

    iput-wide p1, p0, Lcom/mg/ola/a/a/b/n;->y:J

    return-void
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->w:Z

    return v0
.end method

.method f(J)Z
    .locals 9

    iget v0, p0, Lcom/mg/ola/a/a/b/n;->d:I

    const-wide/16 v1, 0x0

    const/4 v3, 0x1

    if-nez v0, :cond_1

    iput v3, p0, Lcom/mg/ola/a/a/b/n;->d:I

    iget-wide v4, p0, Lcom/mg/ola/a/a/b/n;->c:J

    cmp-long v0, v4, v1

    if-gez v0, :cond_0

    iput-wide p1, p0, Lcom/mg/ola/a/a/b/n;->b:J

    goto :goto_0

    :cond_0
    iget-wide v4, p0, Lcom/mg/ola/a/a/b/n;->c:J

    sub-long v6, p1, v4

    iput-wide v6, p0, Lcom/mg/ola/a/a/b/n;->b:J

    const-wide/16 v4, -0x1

    iput-wide v4, p0, Lcom/mg/ola/a/a/b/n;->c:J

    :cond_1
    :goto_0
    iget v0, p0, Lcom/mg/ola/a/a/b/n;->d:I

    const/4 v4, 0x0

    packed-switch v0, :pswitch_data_0

    return v4

    :pswitch_0
    iget-wide v5, p0, Lcom/mg/ola/a/a/b/n;->x:J

    cmp-long v0, v5, v1

    const/high16 v1, 0x3f800000    # 1.0f

    if-lez v0, :cond_2

    iget-wide v5, p0, Lcom/mg/ola/a/a/b/n;->b:J

    sub-long v7, p1, v5

    long-to-float p1, v7

    iget-wide v5, p0, Lcom/mg/ola/a/a/b/n;->x:J

    long-to-float p2, v5

    div-float/2addr p1, p2

    goto :goto_1

    :cond_2
    const/high16 p1, 0x3f800000    # 1.0f

    :goto_1
    cmpl-float p2, p1, v1

    if-ltz p2, :cond_7

    iget p2, p0, Lcom/mg/ola/a/a/b/n;->r:I

    iget v0, p0, Lcom/mg/ola/a/a/b/n;->A:I

    if-lt p2, v0, :cond_4

    iget p2, p0, Lcom/mg/ola/a/a/b/n;->A:I

    const/4 v0, -0x1

    if-ne p2, v0, :cond_3

    goto :goto_2

    :cond_3
    invoke-static {p1, v1}, Ljava/lang/Math;->min(FF)F

    move-result p1

    const/4 v4, 0x1

    goto :goto_4

    :cond_4
    :goto_2
    iget-object p2, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    if-eqz p2, :cond_5

    iget-object p2, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result p2

    const/4 v0, 0x0

    :goto_3
    if-ge v0, p2, :cond_5

    iget-object v2, p0, Lcom/mg/ola/a/a/b/n;->a:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v2, p0}, Lcom/mg/ola/a/a/b/a$a;->d(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    :cond_5
    iget p2, p0, Lcom/mg/ola/a/a/b/n;->B:I

    const/4 v0, 0x2

    if-ne p2, v0, :cond_6

    iget-boolean p2, p0, Lcom/mg/ola/a/a/b/n;->q:Z

    xor-int/2addr p2, v3

    iput-boolean p2, p0, Lcom/mg/ola/a/a/b/n;->q:Z

    :cond_6
    iget p2, p0, Lcom/mg/ola/a/a/b/n;->r:I

    float-to-int v0, p1

    add-int/2addr p2, v0

    iput p2, p0, Lcom/mg/ola/a/a/b/n;->r:I

    rem-float/2addr p1, v1

    iget-wide v2, p0, Lcom/mg/ola/a/a/b/n;->b:J

    iget-wide v5, p0, Lcom/mg/ola/a/a/b/n;->x:J

    add-long v7, v2, v5

    iput-wide v7, p0, Lcom/mg/ola/a/a/b/n;->b:J

    :cond_7
    :goto_4
    iget-boolean p2, p0, Lcom/mg/ola/a/a/b/n;->q:Z

    if-eqz p2, :cond_8

    sub-float p1, v1, p1

    :cond_8
    invoke-virtual {p0, p1}, Lcom/mg/ola/a/a/b/n;->a(F)V

    return v4

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public synthetic g()Lcom/mg/ola/a/a/b/a;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/n;->j()Lcom/mg/ola/a/a/b/n;

    move-result-object v0

    return-object v0
.end method

.method h()V
    .locals 3

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    iget-object v2, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v2, v2, v1

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/l;->b()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    :cond_1
    return-void
.end method

.method public j()Lcom/mg/ola/a/a/b/n;
    .locals 7

    invoke-super {p0}, Lcom/mg/ola/a/a/b/a;->g()Lcom/mg/ola/a/a/b/a;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/n;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    iput-object v3, v0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_0

    iget-object v5, v0, Lcom/mg/ola/a/a/b/n;->D:Ljava/util/ArrayList;

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    const-wide/16 v3, -0x1

    iput-wide v3, v0, Lcom/mg/ola/a/a/b/n;->c:J

    iput-boolean v2, v0, Lcom/mg/ola/a/a/b/n;->q:Z

    iput v2, v0, Lcom/mg/ola/a/a/b/n;->r:I

    iput-boolean v2, v0, Lcom/mg/ola/a/a/b/n;->e:Z

    iput v2, v0, Lcom/mg/ola/a/a/b/n;->d:I

    iput-boolean v2, v0, Lcom/mg/ola/a/a/b/n;->t:Z

    iget-object v1, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    if-eqz v1, :cond_1

    array-length v3, v1

    new-array v4, v3, [Lcom/mg/ola/a/a/b/l;

    iput-object v4, v0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4, v3}, Ljava/util/HashMap;-><init>(I)V

    iput-object v4, v0, Lcom/mg/ola/a/a/b/n;->g:Ljava/util/HashMap;

    :goto_1
    if-ge v2, v3, :cond_1

    aget-object v4, v1, v2

    invoke-virtual {v4}, Lcom/mg/ola/a/a/b/l;->a()Lcom/mg/ola/a/a/b/l;

    move-result-object v4

    iget-object v5, v0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    aput-object v4, v5, v2

    iget-object v5, v0, Lcom/mg/ola/a/a/b/n;->g:Ljava/util/HashMap;

    invoke-virtual {v4}, Lcom/mg/ola/a/a/b/l;->c()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    return-object v0
.end method

.method public k()J
    .locals 6

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/n;->e:Z

    if-eqz v0, :cond_1

    iget v0, p0, Lcom/mg/ola/a/a/b/n;->d:I

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {}, Landroid/view/animation/AnimationUtils;->currentAnimationTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/mg/ola/a/a/b/n;->b:J

    sub-long v4, v0, v2

    return-wide v4

    :cond_1
    :goto_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public l()Ljava/lang/Object;
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v0, v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/l;->d()Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public m()F
    .locals 1

    iget v0, p0, Lcom/mg/ola/a/a/b/n;->s:F

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ValueAnimator@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\n    "

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/mg/ola/a/a/b/n;->f:[Lcom/mg/ola/a/a/b/l;

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/l;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method
