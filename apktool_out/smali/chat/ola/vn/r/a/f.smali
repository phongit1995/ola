.class public Lchat/ola/vn/r/a/f;
.super Ljava/lang/Object;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field public static a:S = 0x1s

.field public static b:S = 0x2s

.field public static c:S = 0x4s

.field public static d:S = 0x8s

.field public static e:S = 0xffs


# instance fields
.field public f:Ljava/lang/String;

.field private g:S

.field private h:I

.field private i:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/s;",
            ">;"
        }
    .end annotation
.end field

.field private j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/s;",
            ">;"
        }
    .end annotation
.end field

.field private k:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private m:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private n:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private o:Lchat/ola/vn/entity/s;

.field private p:Z

.field private q:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/google/android/gms/maps/model/MarkerOptions;",
            ">;"
        }
    .end annotation
.end field

.field private r:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/google/android/gms/maps/model/MarkerOptions;",
            ">;"
        }
    .end annotation
.end field

.field private s:Lchat/ola/vn/entity/s;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-short v0, Lchat/ola/vn/r/a/f;->e:S

    iput-short v0, p0, Lchat/ola/vn/r/a/f;->g:S

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->r:Ljava/util/Map;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x1f4

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->l:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->m:Ljava/util/List;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->n:Ljava/util/Map;

    return-void
.end method

.method private s()V
    .locals 2

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->l:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/r/a/f;->a(Lchat/ola/vn/entity/s;Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(J)Lchat/ola/vn/entity/s;
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/s;

    invoke-virtual {v1}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v4, v2, p1

    if-nez v4, :cond_0

    return-object v1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Ljava/lang/String;)Lchat/ola/vn/message/f;
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->n:Ljava/util/Map;

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    return-object p1
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/r/a/f;->h:I

    return-void
.end method

.method public a(Lchat/ola/vn/entity/s;Ljava/util/List;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/s;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    invoke-virtual {p0}, Lchat/ola/vn/r/a/f;->n()V

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->l:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->l:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-short v0, p0, Lchat/ola/vn/r/a/f;->g:S

    sget-short v1, Lchat/ola/vn/r/a/f;->e:S

    and-int/2addr v0, v1

    sget-short v1, Lchat/ola/vn/r/a/f;->e:S

    const/4 v2, 0x6

    const/4 v3, 0x5

    const/4 v4, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    goto/16 :goto_2

    :cond_0
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_7

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v5

    if-eq v5, v3, :cond_6

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v5

    if-ne v5, v2, :cond_2

    goto :goto_1

    :cond_2
    iget-short v5, p0, Lchat/ola/vn/r/a/f;->g:S

    sget-short v6, Lchat/ola/vn/r/a/f;->a:S

    and-int/2addr v5, v6

    sget-short v6, Lchat/ola/vn/r/a/f;->a:S

    const/4 v7, -0x1

    if-ne v5, v6, :cond_3

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->r()B

    move-result v5

    if-eqz v5, :cond_6

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->r()B

    move-result v5

    if-ne v5, v7, :cond_3

    goto :goto_1

    :cond_3
    iget-short v5, p0, Lchat/ola/vn/r/a/f;->g:S

    sget-short v6, Lchat/ola/vn/r/a/f;->b:S

    and-int/2addr v5, v6

    sget-short v6, Lchat/ola/vn/r/a/f;->b:S

    if-ne v5, v6, :cond_4

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->r()B

    move-result v5

    if-eq v5, v4, :cond_6

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->r()B

    move-result v5

    if-ne v5, v7, :cond_4

    goto :goto_1

    :cond_4
    iget-short v5, p0, Lchat/ola/vn/r/a/f;->g:S

    sget-short v6, Lchat/ola/vn/r/a/f;->c:S

    and-int/2addr v5, v6

    sget-short v6, Lchat/ola/vn/r/a/f;->c:S

    if-ne v5, v6, :cond_5

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->r()B

    move-result v5

    const/4 v6, 0x2

    if-eq v5, v6, :cond_6

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->r()B

    move-result v5

    if-ne v5, v7, :cond_5

    goto :goto_1

    :cond_5
    iget-short v5, p0, Lchat/ola/vn/r/a/f;->g:S

    sget-short v6, Lchat/ola/vn/r/a/f;->d:S

    and-int/2addr v5, v6

    sget-short v6, Lchat/ola/vn/r/a/f;->d:S

    if-ne v5, v6, :cond_1

    iget-object v5, v1, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    invoke-static {v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_1

    iget-object v5, v1, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x50

    if-eq v5, v6, :cond_6

    goto :goto_0

    :cond_6
    :goto_1
    iget-object v5, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v5, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_7
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    if-eqz v0, :cond_8

    if-eqz p1, :cond_8

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    int-to-long v0, v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/entity/s;->a(J)V

    :cond_8
    sget-boolean v0, Lchat/ola/vn/util/a;->a:Z

    if-eqz v0, :cond_a

    new-instance v0, Lchat/ola/vn/message/a;

    invoke-direct {v0}, Lchat/ola/vn/message/a;-><init>()V

    new-instance v1, Ljava/util/Random;

    invoke-direct {v1}, Ljava/util/Random;-><init>()V

    const/16 v5, 0xa

    invoke-virtual {v1, v5}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    add-int/lit8 v1, v1, 0x3

    iget-object v5, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    if-lt v1, v5, :cond_9

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    sub-int/2addr v1, v4

    :cond_9
    iget-object v4, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v4, v1, v0}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->n:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :cond_b
    :goto_3
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_d

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-eq v1, v3, :cond_b

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-ne v1, v2, :cond_c

    goto :goto_3

    :cond_c
    iget-object v1, p0, Lchat/ola/vn/r/a/f;->n:Ljava/util/Map;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v4, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_3

    :cond_d
    iput-object p1, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/s;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lchat/ola/vn/r/a/f;->s:Lchat/ola/vn/entity/s;

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    const/4 v3, 0x1

    if-ge v2, v0, :cond_2

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/s;

    invoke-virtual {v4}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v5

    const-wide/16 v7, 0x0

    cmp-long v9, v5, v7

    if-gtz v9, :cond_1

    iput-object v4, p0, Lchat/ola/vn/r/a/f;->s:Lchat/ola/vn/entity/s;

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->s:Lchat/ola/vn/entity/s;

    invoke-virtual {v0, v3}, Lchat/ola/vn/entity/s;->a(B)V

    invoke-interface {p1, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    iget p1, p0, Lchat/ola/vn/r/a/f;->h:I

    if-eq p1, v3, :cond_3

    invoke-virtual {p0, v1}, Lchat/ola/vn/r/a/f;->a(I)V

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/r/a/f;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(S)V
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/r/a/f;->g:S

    if-eq v0, p1, :cond_0

    iput-short p1, p0, Lchat/ola/vn/r/a/f;->g:S

    invoke-direct {p0}, Lchat/ola/vn/r/a/f;->s()V

    :cond_0
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/r/a/f;->p:Z

    return-void
.end method

.method public a()Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x1

    return v0

    :cond_1
    return v1
.end method

.method public a(Lcom/google/android/gms/maps/model/MarkerOptions;)Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->r:Ljava/util/Map;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->r:Ljava/util/Map;

    :cond_1
    invoke-virtual {p1}, Lcom/google/android/gms/maps/model/MarkerOptions;->getSnippet()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->r:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->r:Ljava/util/Map;

    invoke-interface {v1, v0, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_2
    const/4 p1, 0x0

    return p1
.end method

.method public b(I)Lchat/ola/vn/entity/s;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/s;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v0, v0, Lchat/ola/vn/entity/ag;->u:S

    const/4 v1, 0x3

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v0, v0, Lchat/ola/vn/entity/ag;->q:I

    if-lez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v0, v0, Lchat/ola/vn/entity/ag;->q:I

    if-lt v0, v1, :cond_2

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z

    if-nez v0, :cond_3

    :cond_2
    new-instance v0, Lchat/ola/vn/entity/s;

    const/4 v2, 0x6

    invoke-direct {v0, v2}, Lchat/ola/vn/entity/s;-><init>(B)V

    iget-object v2, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->s:Lchat/ola/vn/entity/s;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    iget-object v2, p0, Lchat/ola/vn/r/a/f;->s:Lchat/ola/vn/entity/s;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    new-instance v0, Lchat/ola/vn/entity/s;

    const/4 v2, 0x5

    invoke-direct {v0, v2}, Lchat/ola/vn/entity/s;-><init>(B)V

    const v3, 0x7f0f042a

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/entity/s;->a(Ljava/lang/String;)V

    const v3, 0x7f0f042b

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/entity/s;->c(Ljava/lang/String;)V

    iget-object v3, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    const v3, 0x7f0f05f6

    const/4 v4, 0x2

    if-eqz v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_8

    new-instance v0, Lchat/ola/vn/entity/s;

    invoke-direct {v0, v4}, Lchat/ola/vn/entity/s;-><init>(B)V

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/entity/s;->a(Ljava/lang/String;)V

    iget-object v3, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v3, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    iget-object v3, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    iget-object v4, p0, Lchat/ola/vn/r/a/f;->i:Ljava/util/List;

    invoke-interface {v3, v4}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :try_start_0
    sget-object v3, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v3}, Lchat/ola/vn/r/a/c;->m()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_6

    new-instance v4, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v5

    invoke-direct {v4, v5, v6}, Ljava/util/Random;-><init>(J)V

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/k;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v4

    iget-object v5, v3, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {v4, v5}, Lchat/ola/vn/util/b;->k(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_6

    new-instance v4, Lchat/ola/vn/entity/s;

    invoke-direct {v4, v1}, Lchat/ola/vn/entity/s;-><init>(B)V

    iget-object v1, v3, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    invoke-virtual {v4, v1}, Lchat/ola/vn/entity/s;->a(Ljava/lang/String;)V

    iget-object v1, v3, Lchat/ola/vn/entity/k;->f:Ljava/lang/String;

    invoke-virtual {v4, v1}, Lchat/ola/vn/entity/s;->c(Ljava/lang/String;)V

    iget-object v1, v3, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    invoke-virtual {v4, v1}, Lchat/ola/vn/entity/s;->d(Ljava/lang/String;)V

    iput-object v3, v4, Lchat/ola/vn/entity/s;->a:Lchat/ola/vn/entity/k;

    add-int/lit8 v1, v0, 0x5

    iget-object v3, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-le v1, v3, :cond_5

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :cond_5
    new-instance v3, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v5

    invoke-direct {v3, v5, v6}, Ljava/util/Random;-><init>(J)V

    sub-int/2addr v1, v0

    invoke-virtual {v3, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    add-int/2addr v0, v1

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v1, v0, v4}, Ljava/util/List;->add(ILjava/lang/Object;)V

    :cond_6
    sget-boolean v1, Lchat/ola/vn/util/a;->a:Z

    if-eqz v1, :cond_9

    new-instance v1, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v3

    invoke-direct {v1, v3, v4}, Ljava/util/Random;-><init>(J)V

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    new-instance v2, Lchat/ola/vn/entity/s;

    const/4 v3, 0x4

    invoke-direct {v2, v3}, Lchat/ola/vn/entity/s;-><init>(B)V

    add-int/2addr v0, v1

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-le v0, v1, :cond_7

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    :cond_7
    iget-object v1, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v1, v0, v2}, Ljava/util/List;->add(ILjava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_8
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/c;->m()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_9

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_9

    new-instance v2, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v5

    invoke-direct {v2, v5, v6}, Ljava/util/Random;-><init>(J)V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v2, v5}, Ljava/util/Random;->nextInt(I)I

    move-result v2

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/k;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    iget-object v5, v0, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {v2, v5}, Lchat/ola/vn/util/b;->k(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_9

    new-instance v2, Lchat/ola/vn/entity/s;

    invoke-direct {v2, v4}, Lchat/ola/vn/entity/s;-><init>(B)V

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/s;->a(Ljava/lang/String;)V

    iget-object v3, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v2, Lchat/ola/vn/entity/s;

    invoke-direct {v2, v1}, Lchat/ola/vn/entity/s;-><init>(B)V

    iget-object v1, v0, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/s;->a(Ljava/lang/String;)V

    iget-object v1, v0, Lchat/ola/vn/entity/k;->f:Ljava/lang/String;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/s;->c(Ljava/lang/String;)V

    iget-object v1, v0, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/s;->d(Ljava/lang/String;)V

    iput-object v0, v2, Lchat/ola/vn/entity/s;->a:Lchat/ola/vn/entity/k;

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :catch_0
    :cond_9
    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->m:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->m:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method

.method public c(I)Lchat/ola/vn/message/f;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public c()Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    invoke-virtual {v0}, Lchat/ola/vn/entity/s;->b()Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public d()V
    .locals 1

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/r/a/f;->a(I)V

    return-void
.end method

.method public e()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/r/a/f;->h:I

    return v0
.end method

.method public f()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public g()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public h()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->k:Ljava/util/List;

    return-object v0
.end method

.method public i()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/r/a/f;->m:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    invoke-virtual {v0}, Lchat/ola/vn/entity/s;->d()Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const-string v0, ""

    return-object v0
.end method

.method public k()J
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    invoke-virtual {v0}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v0

    :catch_0
    const-wide/high16 v0, -0x8000000000000000L

    return-wide v0
.end method

.method public l()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "Lcom/google/android/gms/maps/model/MarkerOptions;",
            ">;"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public m()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public n()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->q:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/r/a/f;->r:Ljava/util/Map;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->r:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->f:Ljava/lang/String;

    return-void
.end method

.method public o()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/r/a/f;->n()V

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->l:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->m:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->n:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/r/a/f;->h:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public p()Lchat/ola/vn/entity/s;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/r/a/f;->o:Lchat/ola/vn/entity/s;

    return-object v0
.end method

.method public q()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/r/a/f;->g:S

    return v0
.end method

.method public r()Z
    .locals 2

    iget-short v0, p0, Lchat/ola/vn/r/a/f;->g:S

    sget-short v1, Lchat/ola/vn/r/a/f;->e:S

    and-int/2addr v0, v1

    sget-short v1, Lchat/ola/vn/r/a/f;->e:S

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method
