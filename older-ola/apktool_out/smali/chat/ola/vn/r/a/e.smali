.class public Lchat/ola/vn/r/a/e;
.super Ljava/lang/Object;


# static fields
.field public static a:Ljava/lang/String; = null

.field public static b:I = 0x0

.field public static c:J = 0x0L

.field public static e:Z = false

.field public static f:Z = false

.field private static h:Ljava/util/Map; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/entity/g;",
            ">;"
        }
    .end annotation
.end field

.field private static y:I = -0x1

.field private static z:I = -0x1


# instance fields
.field private A:Lchat/ola/vn/me/a;

.field public d:J

.field public g:Z

.field private i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;"
        }
    .end annotation
.end field

.field private j:I

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field private l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field private m:Lchat/ola/vn/entity/g;

.field private n:Ljava/lang/String;

.field private o:Lchat/ola/vn/entry/b;

.field private p:Z

.field private q:Ljava/util/Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Stack<",
            "Lchat/ola/vn/entry/a;",
            ">;"
        }
    .end annotation
.end field

.field private r:S

.field private s:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/r/a/d;",
            ">;"
        }
    .end annotation
.end field

.field private t:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private u:I

.field private v:I

.field private w:I

.field private x:B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lchat/ola/vn/r/a/e;->h:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    const/4 v1, 0x1

    iput v1, p0, Lchat/ola/vn/r/a/e;->j:I

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->n:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->o:Lchat/ola/vn/entry/b;

    const/4 v1, 0x0

    iput-boolean v1, p0, Lchat/ola/vn/r/a/e;->p:Z

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    iput-short v1, p0, Lchat/ola/vn/r/a/e;->r:S

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    iput v1, p0, Lchat/ola/vn/r/a/e;->u:I

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lchat/ola/vn/r/a/e;->d:J

    iput-boolean v1, p0, Lchat/ola/vn/r/a/e;->g:Z

    iput-byte v1, p0, Lchat/ola/vn/r/a/e;->x:B

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->A:Lchat/ola/vn/me/a;

    const/4 v0, -0x1

    sput v0, Lchat/ola/vn/r/a/e;->y:I

    sput v0, Lchat/ola/vn/r/a/e;->z:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x5

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    return-void
.end method

.method static synthetic A()Ljava/util/Map;
    .locals 1

    sget-object v0, Lchat/ola/vn/r/a/e;->h:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;I)I
    .locals 0

    iput p1, p0, Lchat/ola/vn/r/a/e;->u:I

    return p1
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;Lchat/ola/vn/entity/g;)Lchat/ola/vn/entity/g;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;Lchat/ola/vn/me/a;)Lchat/ola/vn/me/a;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->A:Lchat/ola/vn/me/a;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->n:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;Ljava/util/Stack;)Ljava/util/Stack;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;S)S
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/r/a/e;->r:S

    return p1
.end method

.method public static a(Lchat/ola/vn/entity/q;)V
    .locals 1

    if-nez p0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/r/a/e$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/r/a/e$2;-><init>(Lchat/ola/vn/entity/q;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/r/a/e;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/r/a/e;->p:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/r/a/e;I)I
    .locals 0

    iput p1, p0, Lchat/ola/vn/r/a/e;->j:I

    return p1
.end method

.method private static b(Lchat/ola/vn/entity/g;)Lchat/ola/vn/entry/b;
    .locals 6

    new-instance v0, Lchat/ola/vn/entry/b;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b;-><init>(Lchat/ola/vn/entity/g;)V

    invoke-virtual {p0}, Lchat/ola/vn/entity/g;->d()J

    move-result-wide v1

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v5

    invoke-virtual {v5}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v5

    invoke-static {v1, v2, v3, v4, v5}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entry/b;->h:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_4

    const-string v1, "rss"

    invoke-static {p0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const p0, 0x7f0f00f8

    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p0

    :goto_0
    invoke-virtual {v0, p0}, Lchat/ola/vn/entry/b;->a(Ljava/lang/String;)V

    return-object v0

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    sget-object p0, Lchat/ola/vn/c/x;->d:Ljava/lang/String;

    if-eqz p0, :cond_1

    sget-object p0, Lchat/ola/vn/c/x;->d:Ljava/lang/String;

    goto :goto_0

    :cond_1
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_2
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v2, 0x0

    invoke-virtual {v1, p0, v2}, Lchat/ola/vn/message/g;->f(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p0

    if-eqz p0, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_3
    iget-object p0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p0}, Lchat/ola/vn/entity/g;->w()Ljava/lang/String;

    move-result-object p0

    goto :goto_0

    :cond_4
    return-object v0
.end method

.method static synthetic b(Lchat/ola/vn/r/a/e;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/r/a/e;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    return-object p1
.end method

.method public static b(Ljava/util/List;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/4 v1, 0x0

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    :goto_0
    if-ge v1, v2, :cond_4

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    const/4 v5, 0x4

    if-ne v4, v5, :cond_0

    :goto_1
    sput v1, Lchat/ola/vn/r/a/e;->y:I

    goto :goto_2

    :cond_0
    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    const/4 v5, 0x5

    if-ne v4, v5, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    const/4 v5, 0x3

    if-ne v4, v5, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    const/16 v5, 0x9

    if-ne v4, v5, :cond_3

    sput v1, Lchat/ola/vn/r/a/e;->z:I

    :cond_3
    :goto_2
    invoke-static {v3}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/entity/g;)Lchat/ola/vn/entry/b;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    return-object v0

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p0, 0x0

    return-object p0
.end method

.method public static d(Ljava/lang/String;)Lchat/ola/vn/entity/g;
    .locals 2

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    new-instance p0, Lchat/ola/vn/entity/g;

    invoke-direct {p0}, Lchat/ola/vn/entity/g;-><init>()V

    const/16 v0, 0xa

    invoke-virtual {p0, v0}, Lchat/ola/vn/entity/g;->d(S)V

    const-wide/16 v0, 0x0

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/entity/g;->a(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method

.method static synthetic e(I)I
    .locals 0

    sput p0, Lchat/ola/vn/r/a/e;->y:I

    return p0
.end method

.method public static e(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/g;

    sget-object v1, Lchat/ola/vn/r/a/e;->h:Ljava/util/Map;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic f(I)I
    .locals 0

    sput p0, Lchat/ola/vn/r/a/e;->z:I

    return p0
.end method

.method public static f(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/q;",
            ">;)V"
        }
    .end annotation

    if-nez p0, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Lchat/ola/vn/r/a/e$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/r/a/e$3;-><init>(Ljava/util/List;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static z()V
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/r/a/e;->h:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/r/a/e;->r:S

    return v0
.end method

.method public a(I)V
    .locals 3

    iget v0, p0, Lchat/ola/vn/r/a/e;->j:I

    iput p1, p0, Lchat/ola/vn/r/a/e;->j:I

    const/4 v1, 0x1

    if-eq p1, v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    :cond_1
    :goto_0
    iget-object v1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/r/a/d;

    invoke-interface {v2, v0, p1}, Lchat/ola/vn/r/a/d;->a(II)V

    goto :goto_1

    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;)V
    .locals 6

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-static {p1}, Lchat/ola/vn/r/a/e;->b(Lchat/ola/vn/entity/g;)Lchat/ola/vn/entry/b;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    if-nez v1, :cond_0

    const/4 v1, -0x1

    sput v1, Lchat/ola/vn/r/a/e;->y:I

    sput v1, Lchat/ola/vn/r/a/e;->z:I

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :cond_0
    const/4 v1, 0x0

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    const/4 v3, 0x0

    :goto_0
    if-ge v1, v2, :cond_1

    :try_start_2
    iget-object v4, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entry/b;

    invoke-virtual {v4}, Lchat/ola/vn/entry/b;->d()I

    move-result v4
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    const/16 v5, 0x9

    if-ne v4, v5, :cond_1

    add-int/lit8 v3, v3, 0x1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    const/4 v3, 0x0

    :catch_1
    :cond_1
    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1, v3, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/r/a/d;

    iget-object v2, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1, v0, v2}, Lchat/ola/vn/r/a/d;->a(Ljava/util/List;Ljava/util/List;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    :catch_2
    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2

    cmp-long v4, v0, v2

    if-nez v4, :cond_7

    const/4 p1, 0x0

    if-eqz p2, :cond_5

    :try_start_0
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_5

    invoke-static {p2}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_3
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2

    iget-object v4, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v4

    cmp-long v6, v2, v4

    if-nez v6, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_4
    if-eqz p2, :cond_6

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {p1, p2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_0
    :cond_5
    move-object p2, p1

    :catch_1
    :cond_6
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/r/a/d;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {v0, p2, v1}, Lchat/ola/vn/r/a/d;->b(Ljava/util/List;Ljava/util/List;)V

    goto :goto_2

    :cond_7
    iput-object p1, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    const/4 v0, 0x0

    invoke-interface {p2, v0, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    if-eqz p2, :cond_8

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_8

    invoke-static {p2}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    :cond_8
    iget-object p2, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_3
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/r/a/d;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {v0, p1, v1}, Lchat/ola/vn/r/a/d;->a(Lchat/ola/vn/entity/g;Ljava/util/List;)V

    goto :goto_3

    :cond_9
    return-void
.end method

.method public a(Lchat/ola/vn/entry/a;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->size()I

    move-result v0

    const/4 v1, 0x6

    if-lt v0, v1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/Stack;->remove(I)Ljava/lang/Object;

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/a;

    iget-object v1, v0, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    if-nez v1, :cond_4

    iget-object v1, p1, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    if-eqz v1, :cond_5

    :cond_4
    iget-object v0, v0, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    iget-object v1, p1, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    goto :goto_0

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/me/a;)V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/me/a;Z)V

    return-void
.end method

.method public a(Lchat/ola/vn/me/a;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->A:Lchat/ola/vn/me/a;

    if-eqz p2, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Lchat/ola/vn/me/a;)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/r/a/d;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_2

    iget-object v2, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/r/a/d;

    invoke-interface {v2}, Lchat/ola/vn/r/a/d;->C()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1}, Lchat/ola/vn/r/a/d;->C()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_1

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    const/4 p2, -0x1

    sput p2, Lchat/ola/vn/r/a/e;->y:I

    sput p2, Lchat/ola/vn/r/a/e;->z:I

    invoke-static {p3}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->n:Ljava/lang/String;

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/r/a/e;->j:I

    iput-boolean p1, p0, Lchat/ola/vn/r/a/e;->p:Z

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/r/a/d;

    iget-object p3, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {p2, p3}, Lchat/ola/vn/r/a/d;->e(Ljava/util/List;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/r/a/d;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    invoke-interface {v0, v1}, Lchat/ola/vn/r/a/d;->d(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :cond_2
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/r/a/e;->p:Z

    return-void
.end method

.method public a(Lchat/ola/vn/entry/b;)Z
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    const/4 v1, 0x1

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/b;

    iget-object v3, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    if-eqz v3, :cond_0

    iget-object v3, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->p()B

    move-result v3

    if-nez v3, :cond_2

    iget-object v3, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v3

    iget-object v5, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v5}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v5

    cmp-long v7, v3, v5

    if-nez v7, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/r/a/d;

    iget-object v3, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v0, v2, v3}, Lchat/ola/vn/r/a/d;->a(Lchat/ola/vn/entry/b;Ljava/util/List;)V

    goto :goto_0

    :cond_1
    return v1

    :cond_2
    iget-object v3, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->m()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->m()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/r/a/d;

    iget-object v3, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v0, v2, v3}, Lchat/ola/vn/r/a/d;->a(Lchat/ola/vn/entry/b;Ljava/util/List;)V

    goto :goto_1

    :cond_3
    return v1

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_5
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/b;

    iget-object v3, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    if-eqz v3, :cond_5

    iget-object v3, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v3

    iget-object v5, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v5}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v5

    cmp-long v7, v3, v5

    if-nez v7, :cond_5

    iget-object p1, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->d()J

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_2
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/r/a/d;

    iget-object v3, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {v0, v2, v3}, Lchat/ola/vn/r/a/d;->b(Lchat/ola/vn/entry/b;Ljava/util/List;)V

    goto :goto_2

    :cond_6
    return v1

    :cond_7
    const/4 p1, 0x0

    return p1
.end method

.method public a(Ljava/lang/String;)Z
    .locals 6

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    return v1

    :cond_0
    const-string v0, "my diary"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    const-string v0, "mariage diary"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return v1

    :cond_1
    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x2

    if-gt v0, v2, :cond_2

    return v1

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    const/4 v2, 0x0

    if-nez v0, :cond_3

    return v2

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_4
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_6

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/af;

    invoke-virtual {v3}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v4

    const-string v5, "#apk"

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    invoke-virtual {v3}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v4

    const-string v5, "#ola"

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    invoke-virtual {v3}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v4

    const-string v5, "#hai"

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    invoke-virtual {v3}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v4

    const-string v5, "#daptrung"

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    goto :goto_0

    :cond_5
    invoke-virtual {v3}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    return v1

    :cond_6
    return v2

    :cond_7
    return v1
.end method

.method public b(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    if-nez v0, :cond_0

    const-string p1, ""

    return-object p1

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/af;

    invoke-virtual {v1}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Lchat/ola/vn/entity/af;->a()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_2
    const-string p1, ""

    return-object p1

    :cond_3
    const p1, 0x7f0f0517

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public b()Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->i:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_1
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_c

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/af;

    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "rs"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const v3, 0x7f0806e2

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto/16 :goto_1

    :cond_2
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "me"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    const v3, 0x7f0806e1

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto/16 :goto_1

    :cond_3
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "lk"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    const v3, 0x7f080776

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto/16 :goto_1

    :cond_4
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "#daptrung"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    const v3, 0x7f0806d1

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto :goto_1

    :cond_5
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "#apk"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    const v3, 0x7f0806cf

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto :goto_1

    :cond_6
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "#ola"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_7

    const v3, 0x7f0806db

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto :goto_1

    :cond_7
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "#hai"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_8

    const v3, 0x7f0806d7

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto :goto_1

    :cond_8
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "my diary"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_9

    const v3, 0x7f0806dd

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    goto :goto_1

    :cond_9
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "mariage diary"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    const v3, 0x7f0806d0

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/af;->a(I)V

    :cond_a
    :goto_1
    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "tl"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_b

    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v3

    const-string v4, "md"

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_b

    invoke-virtual {v2}, Lchat/ola/vn/entity/af;->b()Ljava/lang/String;

    move-result-object v2

    const-string v3, "av"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_b
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    :cond_c
    return-object v0

    :catch_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    return-object v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/r/a/e;->v:I

    return-void
.end method

.method public b(Lchat/ola/vn/entry/a;)V
    .locals 6

    const/4 v0, -0x1

    :try_start_0
    sput v0, Lchat/ola/vn/r/a/e;->y:I

    sput v0, Lchat/ola/vn/r/a/e;->z:I

    iget-object v0, p1, Lchat/ola/vn/entry/a;->a:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v0, 0x0

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_4

    iget-object v3, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entry/b;

    iget-object v4, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    const/4 v5, 0x4

    if-ne v4, v5, :cond_0

    :goto_1
    sput v2, Lchat/ola/vn/r/a/e;->y:I

    goto :goto_2

    :cond_0
    iget-object v4, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    const/4 v5, 0x5

    if-ne v4, v5, :cond_1

    goto :goto_1

    :cond_1
    iget-object v4, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->k()S

    move-result v4

    const/4 v5, 0x3

    if-ne v4, v5, :cond_2

    goto :goto_1

    :cond_2
    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->k()S

    move-result v3

    const/16 v4, 0x9

    if-ne v3, v4, :cond_3

    sput v2, Lchat/ola/vn/r/a/e;->z:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :cond_3
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    :cond_4
    :try_start_2
    iget-object v1, p1, Lchat/ola/vn/entry/a;->b:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/r/a/e;->n:Ljava/lang/String;

    iput v0, p0, Lchat/ola/vn/r/a/e;->j:I

    iput-boolean v0, p0, Lchat/ola/vn/r/a/e;->p:Z

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/r/a/d;

    iget-object v2, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1, p1, v2}, Lchat/ola/vn/r/a/d;->a(Lchat/ola/vn/entry/a;Ljava/util/List;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_3

    :catch_1
    :cond_5
    return-void
.end method

.method public b(Lchat/ola/vn/r/a/d;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_2

    iget-object v2, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/r/a/d;

    invoke-interface {v2}, Lchat/ola/vn/r/a/d;->C()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1}, Lchat/ola/vn/r/a/d;->C()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    return-void

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method public b(Ljava/lang/String;SLjava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    const/4 p2, -0x1

    sput p2, Lchat/ola/vn/r/a/e;->y:I

    sput p2, Lchat/ola/vn/r/a/e;->z:I

    invoke-static {p3}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    iput-object p1, p0, Lchat/ola/vn/r/a/e;->n:Ljava/lang/String;

    const/4 p2, 0x0

    iput p2, p0, Lchat/ola/vn/r/a/e;->j:I

    iput-boolean p2, p0, Lchat/ola/vn/r/a/e;->p:Z

    if-nez p1, :cond_3

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->u()I

    move-result p1

    const/4 p3, 0x1

    if-lez p1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/entry/b;->a()Lchat/ola/vn/entry/b;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-le v1, p1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    add-int/2addr p1, p3

    invoke-interface {v1, p1, v0}, Ljava/util/List;->add(ILjava/lang/Object;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    :goto_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    const/16 v0, 0x75

    invoke-static {p1, v0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;I)V

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, p2}, Lchat/ola/vn/r/a/e;->d(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->I()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide p1

    iput-wide p1, p0, Lchat/ola/vn/r/a/e;->d:J
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_3
    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p2

    if-eqz p2, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/r/a/d;

    iget-object p3, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {p2, p3}, Lchat/ola/vn/r/a/d;->e(Ljava/util/List;)V

    goto :goto_1

    :cond_4
    return-void
.end method

.method public c()I
    .locals 2

    iget v0, p0, Lchat/ola/vn/r/a/e;->j:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/r/a/e;->j()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/r/a/e;->j:I

    :cond_0
    iget v0, p0, Lchat/ola/vn/r/a/e;->j:I

    return v0
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/r/a/e;->w:I

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/r/a/d;

    invoke-interface {v1, p1}, Lchat/ola/vn/r/a/d;->g(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    new-instance v0, Lchat/ola/vn/entity/x;

    invoke-direct {v0}, Lchat/ola/vn/entity/x;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    const/4 p1, 0x1

    iput-byte p1, v0, Lchat/ola/vn/entity/x;->a:B

    invoke-static {v0}, Lchat/ola/vn/g;->a(Lchat/ola/vn/entity/x;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/r/a/d;

    iget-object v2, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1, p1, v2}, Lchat/ola/vn/r/a/d;->a(Ljava/util/List;Ljava/util/List;)V

    goto :goto_0

    :cond_2
    return-void
.end method

.method public d()Lchat/ola/vn/entry/a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->q:Ljava/util/Stack;

    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/a;

    return-object v0

    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d(I)V
    .locals 2

    iget v0, p0, Lchat/ola/vn/r/a/e;->u:I

    if-eq v0, p1, :cond_1

    iput p1, p0, Lchat/ola/vn/r/a/e;->u:I

    if-lez p1, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lchat/ola/vn/util/c/b;->b(I)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/r/a/d;

    invoke-interface {v1, p1}, Lchat/ola/vn/r/a/d;->d(I)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    if-eqz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    new-instance v1, Lchat/ola/vn/entity/x;

    invoke-direct {v1}, Lchat/ola/vn/entity/x;-><init>()V

    iput-object v0, v1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    const/4 v0, 0x1

    iput-byte v0, v1, Lchat/ola/vn/entity/x;->a:B

    invoke-static {v1}, Lchat/ola/vn/g;->a(Lchat/ola/vn/entity/x;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/r/a/d;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    invoke-interface {v0, v1}, Lchat/ola/vn/r/a/d;->f(Ljava/util/List;)V

    goto :goto_1

    :cond_1
    return-void
.end method

.method public e()V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/r/a/e$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/r/a/e$1;-><init>(Lchat/ola/vn/r/a/e;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public f()Lchat/ola/vn/entry/b;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->o:Lchat/ola/vn/entry/b;

    return-object v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->n:Ljava/lang/String;

    return-object v0
.end method

.method public h()Ljava/lang/CharSequence;
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0, v0}, Lchat/ola/vn/r/a/e;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v1, "rss"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const v0, 0x7f0f00f8

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_1
    :try_start_0
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    :cond_2
    return-object v0
.end method

.method public i()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public j()I
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v1, v0

    return v1

    :catch_0
    return v0
.end method

.method public k()J
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->d()I

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_0

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    return-wide v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sub-int/2addr v1, v2

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public l()J
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->n()J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public m()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/r/a/e;->p:Z

    return v0
.end method

.method public n()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->s:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/r/a/d;

    invoke-interface {v1}, Lchat/ola/vn/r/a/d;->D()V

    goto :goto_0

    :cond_1
    return-void
.end method

.method public o()J
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->m:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    return-wide v0

    :cond_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public p()J
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    :cond_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public q()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/r/a/e;->l:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public r()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/r/a/e;->v:I

    return v0
.end method

.method public s()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/r/a/e;->w:I

    return v0
.end method

.method public t()V
    .locals 6

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/r/a/e;->g:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    invoke-interface {v0}, Lchat/ola/vn/r/a;->a()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    add-int/2addr v3, v2

    goto :goto_0

    :cond_1
    const/4 v3, 0x0

    :goto_0
    if-lez v3, :cond_2

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v3}, Ljava/util/ArrayList;-><init>(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v0, :cond_2

    :try_start_1
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_2

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    const/16 v4, 0x32

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    const/4 v4, 0x0

    :goto_1
    if-ge v4, v3, :cond_2

    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :catch_0
    :cond_2
    :try_start_2
    new-instance v0, Lchat/ola/vn/entity/aa;

    invoke-direct {v0}, Lchat/ola/vn/entity/aa;-><init>()V

    const-string v3, "mehistory"

    iput-object v3, v0, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    const/4 v3, 0x1

    if-eqz v1, :cond_3

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_3

    invoke-static {v1}, Lchat/ola/vn/h/b;->b(Ljava/util/List;)[B

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/aa;->b:[B

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v4, "bmk"

    new-array v3, v3, [Lchat/ola/vn/entity/aa;

    aput-object v0, v3, v2

    invoke-virtual {v1, v4, v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    return-void

    :cond_3
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v4, "bmk"

    new-array v3, v3, [Lchat/ola/vn/entity/aa;

    aput-object v0, v3, v2

    invoke-virtual {v1, v4, v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public u()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/r/a/e;->u:I

    return v0
.end method

.method public v()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->t:Ljava/util/List;

    return-object v0
.end method

.method public w()Z
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    sget v1, Lchat/ola/vn/r/a/e;->y:I

    if-gez v1, :cond_0

    return v0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sget v2, Lchat/ola/vn/r/a/e;->y:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    sub-int/2addr v1, v2

    const/16 v2, 0xf

    if-ge v1, v2, :cond_1

    const/4 v0, 0x0

    :catch_0
    :cond_1
    return v0
.end method

.method public x()Z
    .locals 3

    const/4 v0, 0x1

    :try_start_0
    sget v1, Lchat/ola/vn/r/a/e;->z:I

    if-gez v1, :cond_0

    return v0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/r/a/e;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sget v2, Lchat/ola/vn/r/a/e;->z:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    sub-int/2addr v1, v2

    const/16 v2, 0x1e

    if-ge v1, v2, :cond_1

    const/4 v0, 0x0

    :catch_0
    :cond_1
    return v0
.end method

.method public y()Lchat/ola/vn/me/a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/e;->A:Lchat/ola/vn/me/a;

    return-object v0
.end method
