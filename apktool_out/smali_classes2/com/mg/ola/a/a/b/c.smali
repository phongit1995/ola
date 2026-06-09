.class public final Lcom/mg/ola/a/a/b/c;
.super Lcom/mg/ola/a/a/b/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/a/a/b/c$b;,
        Lcom/mg/ola/a/a/b/c$e;,
        Lcom/mg/ola/a/a/b/c$c;,
        Lcom/mg/ola/a/a/b/c$a;,
        Lcom/mg/ola/a/a/b/c$d;
    }
.end annotation


# instance fields
.field b:Z

.field private c:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/a;",
            ">;"
        }
    .end annotation
.end field

.field private d:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lcom/mg/ola/a/a/b/a;",
            "Lcom/mg/ola/a/a/b/c$e;",
            ">;"
        }
    .end annotation
.end field

.field private e:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/c$e;",
            ">;"
        }
    .end annotation
.end field

.field private f:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/c$e;",
            ">;"
        }
    .end annotation
.end field

.field private g:Z

.field private h:Lcom/mg/ola/a/a/b/c$a;

.field private i:Z

.field private j:J

.field private k:Lcom/mg/ola/a/a/b/n;

.field private l:J


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/a;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c;->c:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c;->d:Ljava/util/HashMap;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->g:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c;->h:Lcom/mg/ola/a/a/b/c$a;

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/c;->b:Z

    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/c;->i:Z

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/mg/ola/a/a/b/c;->j:J

    iput-object v0, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/mg/ola/a/a/b/c;->l:J

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/b/c;->c:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic a(Lcom/mg/ola/a/a/b/c;Z)Z
    .locals 0

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/c;->i:Z

    return p1
.end method

.method static synthetic b(Lcom/mg/ola/a/a/b/c;)Ljava/util/HashMap;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/b/c;->d:Ljava/util/HashMap;

    return-object p0
.end method

.method static synthetic c(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic d(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    return-object p0
.end method

.method private i()V
    .locals 10

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->g:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_2

    iget-object v4, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/c$e;

    iget-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    if-eqz v5, :cond_0

    iget-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-nez v5, :cond_1

    :cond_0
    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    :goto_1
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_6

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_2
    if-ge v4, v3, :cond_5

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mg/ola/a/a/b/c$e;

    iget-object v6, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v6, v5, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    if-eqz v6, :cond_4

    iget-object v6, v5, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    const/4 v7, 0x0

    :goto_3
    if-ge v7, v6, :cond_4

    iget-object v8, v5, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    invoke-virtual {v8, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/mg/ola/a/a/b/c$e;

    iget-object v9, v8, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    invoke-virtual {v9, v5}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    iget-object v9, v8, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v9

    if-nez v9, :cond_3

    invoke-virtual {v2, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_3
    add-int/lit8 v7, v7, 0x1

    goto :goto_3

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_5
    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    goto :goto_1

    :cond_6
    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/c;->g:Z

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-eq v0, v1, :cond_b

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Circular dependencies cannot exist in AnimatorSet"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_7
    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v2, 0x0

    :goto_4
    if-ge v2, v0, :cond_b

    iget-object v3, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/c$e;

    iget-object v4, v3, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    if-eqz v4, :cond_a

    iget-object v4, v3, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lez v4, :cond_a

    iget-object v4, v3, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    const/4 v5, 0x0

    :goto_5
    if-ge v5, v4, :cond_a

    iget-object v6, v3, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/mg/ola/a/a/b/c$c;

    iget-object v7, v3, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    if-nez v7, :cond_8

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    iput-object v7, v3, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    :cond_8
    iget-object v7, v3, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    iget-object v8, v6, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v7, v8}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_9

    iget-object v7, v3, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    iget-object v6, v6, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v7, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_9
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    :cond_a
    iput-boolean v1, v3, Lcom/mg/ola/a/a/b/c$e;->f:Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    :cond_b
    return-void
.end method


# virtual methods
.method public synthetic a(J)Lcom/mg/ola/a/a/b/a;
    .locals 0

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/a/a/b/c;->b(J)Lcom/mg/ola/a/a/b/c;

    move-result-object p1

    return-object p1
.end method

.method public a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;
    .locals 1

    if-eqz p1, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->g:Z

    new-instance v0, Lcom/mg/ola/a/a/b/c$b;

    invoke-direct {v0, p0, p1}, Lcom/mg/ola/a/a/b/c$b;-><init>(Lcom/mg/ola/a/a/b/c;Lcom/mg/ola/a/a/b/a;)V

    return-object v0

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a()V
    .locals 10

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->b:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/mg/ola/a/a/b/c;->i:Z

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/c;->i()V

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_3

    iget-object v3, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/c$e;

    iget-object v4, v3, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v4}, Lcom/mg/ola/a/a/b/a;->f()Ljava/util/ArrayList;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-lez v5, :cond_2

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-virtual {v5}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_0
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mg/ola/a/a/b/a$a;

    instance-of v6, v5, Lcom/mg/ola/a/a/b/c$d;

    if-nez v6, :cond_1

    instance-of v6, v5, Lcom/mg/ola/a/a/b/c$a;

    if-eqz v6, :cond_0

    :cond_1
    iget-object v6, v3, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v6, v5}, Lcom/mg/ola/a/a/b/a;->b(Lcom/mg/ola/a/a/b/a$a;)V

    goto :goto_1

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_3
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    const/4 v3, 0x0

    :goto_2
    if-ge v3, v1, :cond_8

    iget-object v4, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/c$e;

    iget-object v5, p0, Lcom/mg/ola/a/a/b/c;->h:Lcom/mg/ola/a/a/b/c$a;

    if-nez v5, :cond_4

    new-instance v5, Lcom/mg/ola/a/a/b/c$a;

    invoke-direct {v5, p0, p0}, Lcom/mg/ola/a/a/b/c$a;-><init>(Lcom/mg/ola/a/a/b/c;Lcom/mg/ola/a/a/b/c;)V

    iput-object v5, p0, Lcom/mg/ola/a/a/b/c;->h:Lcom/mg/ola/a/a/b/c$a;

    :cond_4
    iget-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    if-eqz v5, :cond_7

    iget-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-nez v5, :cond_5

    goto :goto_4

    :cond_5
    iget-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    const/4 v6, 0x0

    :goto_3
    if-ge v6, v5, :cond_6

    iget-object v7, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v7, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/mg/ola/a/a/b/c$c;

    iget-object v8, v7, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    iget-object v8, v8, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    new-instance v9, Lcom/mg/ola/a/a/b/c$d;

    iget v7, v7, Lcom/mg/ola/a/a/b/c$c;->b:I

    invoke-direct {v9, p0, v4, v7}, Lcom/mg/ola/a/a/b/c$d;-><init>(Lcom/mg/ola/a/a/b/c;Lcom/mg/ola/a/a/b/c$e;I)V

    invoke-virtual {v8, v9}, Lcom/mg/ola/a/a/b/a;->a(Lcom/mg/ola/a/a/b/a$a;)V

    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    :cond_6
    iget-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/ArrayList;

    iput-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->c:Ljava/util/ArrayList;

    goto :goto_5

    :cond_7
    :goto_4
    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_5
    iget-object v4, v4, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    iget-object v5, p0, Lcom/mg/ola/a/a/b/c;->h:Lcom/mg/ola/a/a/b/c$a;

    invoke-virtual {v4, v5}, Lcom/mg/ola/a/a/b/a;->a(Lcom/mg/ola/a/a/b/a$a;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_8
    iget-wide v3, p0, Lcom/mg/ola/a/a/b/c;->j:J

    const-wide/16 v5, 0x0

    cmp-long v1, v3, v5

    if-gtz v1, :cond_9

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_a

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/c$e;

    iget-object v3, v2, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v3}, Lcom/mg/ola/a/a/b/a;->a()V

    iget-object v3, p0, Lcom/mg/ola/a/a/b/c;->c:Ljava/util/ArrayList;

    iget-object v2, v2, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_6

    :cond_9
    const/4 v1, 0x2

    new-array v1, v1, [F

    fill-array-data v1, :array_0

    invoke-static {v1}, Lcom/mg/ola/a/a/b/n;->b([F)Lcom/mg/ola/a/a/b/n;

    move-result-object v1

    iput-object v1, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    iget-wide v3, p0, Lcom/mg/ola/a/a/b/c;->j:J

    invoke-virtual {v1, v3, v4}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    new-instance v3, Lcom/mg/ola/a/a/b/c$1;

    invoke-direct {v3, p0, v2}, Lcom/mg/ola/a/a/b/c$1;-><init>(Lcom/mg/ola/a/a/b/c;Ljava/util/ArrayList;)V

    invoke-virtual {v1, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/a$a;)V

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/n;->a()V

    :cond_a
    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    if-eqz v1, :cond_b

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_7
    if-ge v3, v2, :cond_b

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v4, p0}, Lcom/mg/ola/a/a/b/a$a;->c(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_7

    :cond_b
    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-nez v1, :cond_c

    iget-wide v1, p0, Lcom/mg/ola/a/a/b/c;->j:J

    cmp-long v3, v1, v5

    if-nez v3, :cond_c

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->i:Z

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    if-eqz v1, :cond_c

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    :goto_8
    if-ge v0, v2, :cond_c

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v3, p0}, Lcom/mg/ola/a/a/b/a$a;->a(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_8

    :cond_c
    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x3f800000    # 1.0f
    .end array-data
.end method

.method public a(Landroid/view/animation/Interpolator;)V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/c$e;

    iget-object v1, v1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v1, p1}, Lcom/mg/ola/a/a/b/a;->a(Landroid/view/animation/Interpolator;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public b(J)Lcom/mg/ola/a/a/b/c;
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-gez v2, :cond_0

    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string p2, "duration must be a value of zero or greater"

    invoke-direct {p1, p2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/c$e;

    iget-object v1, v1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v1, p1, p2}, Lcom/mg/ola/a/a/b/a;->a(J)Lcom/mg/ola/a/a/b/a;

    goto :goto_0

    :cond_1
    iput-wide p1, p0, Lcom/mg/ola/a/a/b/c;->l:J

    return-object p0
.end method

.method public b()V
    .locals 3

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->b:Z

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/c;->e()Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v2, p0}, Lcom/mg/ola/a/a/b/a$a;->b(Lcom/mg/ola/a/a/b/a;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/n;->d()Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/n;->b()V

    goto :goto_2

    :cond_1
    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_2

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/c$e;

    iget-object v2, v2, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/a;->b()V

    goto :goto_1

    :cond_2
    :goto_2
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v1, p0}, Lcom/mg/ola/a/a/b/a$a;->a(Lcom/mg/ola/a/a/b/a;)V

    goto :goto_3

    :cond_3
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->i:Z

    :cond_4
    return-void
.end method

.method public c()V
    .locals 3

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->b:Z

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/c;->e()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-eq v0, v1, :cond_1

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/c;->i()V

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/c$e;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/c;->h:Lcom/mg/ola/a/a/b/c$a;

    if-nez v2, :cond_0

    new-instance v2, Lcom/mg/ola/a/a/b/c$a;

    invoke-direct {v2, p0, p0}, Lcom/mg/ola/a/a/b/c$a;-><init>(Lcom/mg/ola/a/a/b/c;Lcom/mg/ola/a/a/b/c;)V

    iput-object v2, p0, Lcom/mg/ola/a/a/b/c;->h:Lcom/mg/ola/a/a/b/c$a;

    :cond_0
    iget-object v1, v1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/c;->h:Lcom/mg/ola/a/a/b/c$a;

    invoke-virtual {v1, v2}, Lcom/mg/ola/a/a/b/a;->a(Lcom/mg/ola/a/a/b/a$a;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->k:Lcom/mg/ola/a/a/b/n;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/n;->b()V

    :cond_2
    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/c$e;

    iget-object v1, v1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/a;->c()V

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/a$a;

    invoke-interface {v1, p0}, Lcom/mg/ola/a/a/b/a$a;->a(Lcom/mg/ola/a/a/b/a;)V

    goto :goto_2

    :cond_4
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->i:Z

    :cond_5
    return-void
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/c;->h()Lcom/mg/ola/a/a/b/c;

    move-result-object v0

    return-object v0
.end method

.method public d()Z
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/c$e;

    iget-object v1, v1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/a;->d()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_1
    const/4 v0, 0x0

    return v0
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/a/a/b/c;->i:Z

    return v0
.end method

.method public synthetic g()Lcom/mg/ola/a/a/b/a;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/c;->h()Lcom/mg/ola/a/a/b/c;

    move-result-object v0

    return-object v0
.end method

.method public h()Lcom/mg/ola/a/a/b/c;
    .locals 8

    invoke-super {p0}, Lcom/mg/ola/a/a/b/a;->g()Lcom/mg/ola/a/a/b/a;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/c;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/mg/ola/a/a/b/c;->g:Z

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/mg/ola/a/a/b/c;->b:Z

    iput-boolean v1, v0, Lcom/mg/ola/a/a/b/c;->i:Z

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/a/a/b/c;->c:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/a/a/b/c;->d:Ljava/util/HashMap;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, v0, Lcom/mg/ola/a/a/b/c;->f:Ljava/util/ArrayList;

    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iget-object v2, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v3}, Lcom/mg/ola/a/a/b/c$e;->a()Lcom/mg/ola/a/a/b/c$e;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v3, v0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v3, v0, Lcom/mg/ola/a/a/b/c;->d:Ljava/util/HashMap;

    iget-object v5, v4, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v3, v5, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v3, 0x0

    iput-object v3, v4, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    iput-object v3, v4, Lcom/mg/ola/a/a/b/c$e;->c:Ljava/util/ArrayList;

    iput-object v3, v4, Lcom/mg/ola/a/a/b/c$e;->e:Ljava/util/ArrayList;

    iput-object v3, v4, Lcom/mg/ola/a/a/b/c$e;->d:Ljava/util/ArrayList;

    iget-object v4, v4, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v4}, Lcom/mg/ola/a/a/b/a;->f()Ljava/util/ArrayList;

    move-result-object v4

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_1
    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/mg/ola/a/a/b/a$a;

    instance-of v7, v6, Lcom/mg/ola/a/a/b/c$a;

    if-eqz v7, :cond_1

    if-nez v3, :cond_2

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    :cond_2
    invoke-virtual {v3, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mg/ola/a/a/b/a$a;

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_4
    iget-object v2, p0, Lcom/mg/ola/a/a/b/c;->e:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_5
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_6

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v1, v3}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/c$e;

    iget-object v5, v3, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    if-eqz v5, :cond_5

    iget-object v3, v3, Lcom/mg/ola/a/a/b/c$e;->b:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mg/ola/a/a/b/c$c;

    iget-object v6, v5, Lcom/mg/ola/a/a/b/c$c;->a:Lcom/mg/ola/a/a/b/c$e;

    invoke-virtual {v1, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/mg/ola/a/a/b/c$e;

    new-instance v7, Lcom/mg/ola/a/a/b/c$c;

    iget v5, v5, Lcom/mg/ola/a/a/b/c$c;->b:I

    invoke-direct {v7, v6, v5}, Lcom/mg/ola/a/a/b/c$c;-><init>(Lcom/mg/ola/a/a/b/c$e;I)V

    invoke-virtual {v4, v7}, Lcom/mg/ola/a/a/b/c$e;->a(Lcom/mg/ola/a/a/b/c$c;)V

    goto :goto_2

    :cond_6
    return-object v0
.end method
