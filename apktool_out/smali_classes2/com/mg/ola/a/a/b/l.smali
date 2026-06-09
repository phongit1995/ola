.class public Lcom/mg/ola/a/a/b/l;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Cloneable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/a/a/b/l$a;,
        Lcom/mg/ola/a/a/b/l$b;
    }
.end annotation


# static fields
.field private static final i:Lcom/mg/ola/a/a/b/m;

.field private static final j:Lcom/mg/ola/a/a/b/m;

.field private static k:[Ljava/lang/Class;

.field private static l:[Ljava/lang/Class;

.field private static m:[Ljava/lang/Class;

.field private static final n:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/Class;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/reflect/Method;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final o:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/Class;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/reflect/Method;",
            ">;>;"
        }
    .end annotation
.end field


# instance fields
.field a:Ljava/lang/String;

.field protected b:Lcom/mg/ola/a/a/a/c;

.field c:Ljava/lang/reflect/Method;

.field d:Ljava/lang/Class;

.field e:Lcom/mg/ola/a/a/b/i;

.field final f:Ljava/util/concurrent/locks/ReentrantReadWriteLock;

.field final g:[Ljava/lang/Object;

.field private h:Ljava/lang/reflect/Method;

.field private p:Lcom/mg/ola/a/a/b/m;

.field private q:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    new-instance v0, Lcom/mg/ola/a/a/b/f;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/f;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/l;->i:Lcom/mg/ola/a/a/b/m;

    new-instance v0, Lcom/mg/ola/a/a/b/d;

    invoke-direct {v0}, Lcom/mg/ola/a/a/b/d;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/l;->j:Lcom/mg/ola/a/a/b/m;

    const/4 v0, 0x6

    new-array v1, v0, [Ljava/lang/Class;

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-class v2, Ljava/lang/Float;

    const/4 v4, 0x1

    aput-object v2, v1, v4

    sget-object v2, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    const/4 v5, 0x2

    aput-object v2, v1, v5

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v6, 0x3

    aput-object v2, v1, v6

    const-class v2, Ljava/lang/Double;

    const/4 v7, 0x4

    aput-object v2, v1, v7

    const-class v2, Ljava/lang/Integer;

    const/4 v8, 0x5

    aput-object v2, v1, v8

    sput-object v1, Lcom/mg/ola/a/a/b/l;->k:[Ljava/lang/Class;

    new-array v1, v0, [Ljava/lang/Class;

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v2, v1, v3

    const-class v2, Ljava/lang/Integer;

    aput-object v2, v1, v4

    sget-object v2, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v2, v1, v5

    sget-object v2, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    aput-object v2, v1, v6

    const-class v2, Ljava/lang/Float;

    aput-object v2, v1, v7

    const-class v2, Ljava/lang/Double;

    aput-object v2, v1, v8

    sput-object v1, Lcom/mg/ola/a/a/b/l;->l:[Ljava/lang/Class;

    new-array v0, v0, [Ljava/lang/Class;

    sget-object v1, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    aput-object v1, v0, v3

    const-class v1, Ljava/lang/Double;

    aput-object v1, v0, v4

    sget-object v1, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v1, v0, v5

    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v1, v0, v6

    const-class v1, Ljava/lang/Float;

    aput-object v1, v0, v7

    const-class v1, Ljava/lang/Integer;

    aput-object v1, v0, v8

    sput-object v0, Lcom/mg/ola/a/a/b/l;->m:[Ljava/lang/Class;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/l;->n:Ljava/util/HashMap;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/mg/ola/a/a/b/l;->o:Ljava/util/HashMap;

    return-void
.end method

.method private constructor <init>(Lcom/mg/ola/a/a/a/c;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->c:Ljava/lang/reflect/Method;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->h:Ljava/lang/reflect/Method;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->f:Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->g:[Ljava/lang/Object;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/mg/ola/a/a/a/c;->a()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/a/a/a/c;Lcom/mg/ola/a/a/b/l$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/b/l;-><init>(Lcom/mg/ola/a/a/a/c;)V

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->c:Ljava/lang/reflect/Method;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->h:Ljava/lang/reflect/Method;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    new-instance v0, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->f:Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->g:[Ljava/lang/Object;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Lcom/mg/ola/a/a/b/l$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/b/l;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method public static varargs a(Lcom/mg/ola/a/a/a/c;[F)Lcom/mg/ola/a/a/b/l;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mg/ola/a/a/a/c<",
            "*",
            "Ljava/lang/Float;",
            ">;[F)",
            "Lcom/mg/ola/a/a/b/l;"
        }
    .end annotation

    new-instance v0, Lcom/mg/ola/a/a/b/l$a;

    invoke-direct {v0, p0, p1}, Lcom/mg/ola/a/a/b/l$a;-><init>(Lcom/mg/ola/a/a/a/c;[F)V

    return-object v0
.end method

.method public static varargs a(Lcom/mg/ola/a/a/a/c;[I)Lcom/mg/ola/a/a/b/l;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mg/ola/a/a/a/c<",
            "*",
            "Ljava/lang/Integer;",
            ">;[I)",
            "Lcom/mg/ola/a/a/b/l;"
        }
    .end annotation

    new-instance v0, Lcom/mg/ola/a/a/b/l$b;

    invoke-direct {v0, p0, p1}, Lcom/mg/ola/a/a/b/l$b;-><init>(Lcom/mg/ola/a/a/a/c;[I)V

    return-object v0
.end method

.method public static varargs a(Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/l;
    .locals 1

    new-instance v0, Lcom/mg/ola/a/a/b/l$a;

    invoke-direct {v0, p0, p1}, Lcom/mg/ola/a/a/b/l$a;-><init>(Ljava/lang/String;[F)V

    return-object v0
.end method

.method public static varargs a(Ljava/lang/String;[I)Lcom/mg/ola/a/a/b/l;
    .locals 1

    new-instance v0, Lcom/mg/ola/a/a/b/l$b;

    invoke-direct {v0, p0, p1}, Lcom/mg/ola/a/a/b/l$b;-><init>(Ljava/lang/String;[I)V

    return-object v0
.end method

.method static a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    return-object p0

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->toUpperCase(C)C

    move-result v0

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_1
    return-object p0
.end method

.method private a(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .locals 8

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    invoke-static {p2, v0}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    const/4 v0, 0x0

    const/4 v1, 0x1

    if-nez p3, :cond_0

    :try_start_0
    invoke-virtual {p1, p2, v0}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p3
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p3

    :catch_0
    :try_start_1
    invoke-virtual {p1, p2, v0}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    :try_start_2
    invoke-virtual {p1, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    move-exception p2

    goto :goto_0

    :catch_2
    move-exception p2

    move-object p1, v0

    :goto_0
    invoke-virtual {p2}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_1
    move-object p3, p1

    return-object p3

    :cond_0
    new-array p3, v1, [Ljava/lang/Class;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    const-class v3, Ljava/lang/Float;

    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    sget-object v2, Lcom/mg/ola/a/a/b/l;->k:[Ljava/lang/Class;

    goto :goto_2

    :cond_1
    iget-object v2, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    const-class v4, Ljava/lang/Integer;

    invoke-virtual {v2, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    sget-object v2, Lcom/mg/ola/a/a/b/l;->l:[Ljava/lang/Class;

    goto :goto_2

    :cond_2
    iget-object v2, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    const-class v4, Ljava/lang/Double;

    invoke-virtual {v2, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    sget-object v2, Lcom/mg/ola/a/a/b/l;->m:[Ljava/lang/Class;

    goto :goto_2

    :cond_3
    new-array v2, v1, [Ljava/lang/Class;

    iget-object v4, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    aput-object v4, v2, v3

    :goto_2
    array-length v4, v2

    move-object v5, v0

    const/4 v0, 0x0

    :goto_3
    if-ge v0, v4, :cond_4

    aget-object v6, v2, v0

    aput-object v6, p3, v3

    :try_start_3
    invoke-virtual {p1, p2, p3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7
    :try_end_3
    .catch Ljava/lang/NoSuchMethodException; {:try_start_3 .. :try_end_3} :catch_4

    :try_start_4
    iput-object v6, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;
    :try_end_4
    .catch Ljava/lang/NoSuchMethodException; {:try_start_4 .. :try_end_4} :catch_3

    return-object v7

    :catch_3
    move-object v5, v7

    :catch_4
    :try_start_5
    invoke-virtual {p1, p2, p3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7
    :try_end_5
    .catch Ljava/lang/NoSuchMethodException; {:try_start_5 .. :try_end_5} :catch_6

    :try_start_6
    invoke-virtual {v7, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    iput-object v6, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;
    :try_end_6
    .catch Ljava/lang/NoSuchMethodException; {:try_start_6 .. :try_end_6} :catch_5

    return-object v7

    :catch_5
    move-object v5, v7

    :catch_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_3

    :cond_4
    move-object p3, v5

    return-object p3
.end method

.method private a(Ljava/lang/Class;Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Method;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class;",
            "Ljava/util/HashMap<",
            "Ljava/lang/Class;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/reflect/Method;",
            ">;>;",
            "Ljava/lang/String;",
            "Ljava/lang/Class;",
            ")",
            "Ljava/lang/reflect/Method;"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->f:Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;->writeLock()Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;->lock()V

    invoke-virtual {p2, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/HashMap;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/reflect/Method;

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    if-nez v1, :cond_2

    invoke-direct {p0, p1, p3, p4}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    invoke-virtual {p2, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget-object p1, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    invoke-virtual {v0, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_2
    iget-object p1, p0, Lcom/mg/ola/a/a/b/l;->f:Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-virtual {p1}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;->writeLock()Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;->unlock()V

    return-object v1

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/mg/ola/a/a/b/l;->f:Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-virtual {p2}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;->writeLock()Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;

    move-result-object p2

    invoke-virtual {p2}, Ljava/util/concurrent/locks/ReentrantReadWriteLock$WriteLock;->unlock()V

    throw p1
.end method

.method private b(Ljava/lang/Class;)V
    .locals 3

    sget-object v0, Lcom/mg/ola/a/a/b/l;->o:Ljava/util/HashMap;

    const-string v1, "get"

    const/4 v2, 0x0

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/Class;Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->h:Ljava/lang/reflect/Method;

    return-void
.end method


# virtual methods
.method public a()Lcom/mg/ola/a/a/b/l;
    .locals 2

    :try_start_0
    invoke-super {p0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/l;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    iput-object v1, v0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    iput-object v1, v0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/i;->b()Lcom/mg/ola/a/a/b/i;

    move-result-object v1

    iput-object v1, v0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->p:Lcom/mg/ola/a/a/b/m;

    iput-object v1, v0, Lcom/mg/ola/a/a/b/l;->p:Lcom/mg/ola/a/a/b/m;
    :try_end_0
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method a(F)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/b/i;->a(F)Ljava/lang/Object;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->q:Ljava/lang/Object;

    return-void
.end method

.method public a(Lcom/mg/ola/a/a/a/c;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    return-void
.end method

.method a(Ljava/lang/Class;)V
    .locals 3

    sget-object v0, Lcom/mg/ola/a/a/b/l;->n:Ljava/util/HashMap;

    const-string v1, "set"

    iget-object v2, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/Class;Ljava/util/HashMap;Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->c:Ljava/lang/reflect/Method;

    return-void
.end method

.method a(Ljava/lang/Object;)V
    .locals 5

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    if-eqz v0, :cond_2

    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    invoke-virtual {v0, p1}, Lcom/mg/ola/a/a/a/c;->a(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    iget-object v0, v0, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/h;->a()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    invoke-virtual {v2, p1}, Lcom/mg/ola/a/a/a/c;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/mg/ola/a/a/b/h;->a(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_1
    return-void

    :catch_0
    move-exception v0

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->c:Ljava/lang/reflect/Method;

    if-nez v1, :cond_3

    invoke-virtual {p0, v0}, Lcom/mg/ola/a/a/b/l;->a(Ljava/lang/Class;)V

    :cond_3
    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    iget-object v1, v1, Lcom/mg/ola/a/a/b/i;->e:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_4
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/a/a/b/h;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/h;->a()Z

    move-result v3

    if-nez v3, :cond_4

    iget-object v3, p0, Lcom/mg/ola/a/a/b/l;->h:Ljava/lang/reflect/Method;

    if-nez v3, :cond_5

    invoke-direct {p0, v0}, Lcom/mg/ola/a/a/b/l;->b(Ljava/lang/Class;)V

    :cond_5
    :try_start_1
    iget-object v3, p0, Lcom/mg/ola/a/a/b/l;->h:Ljava/lang/reflect/Method;

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v3, p1, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/h;->a(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v2

    invoke-virtual {v2}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_1

    :cond_6
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    return-void
.end method

.method public varargs a([F)V
    .locals 1

    sget-object v0, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/i;->a([F)Lcom/mg/ola/a/a/b/i;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    return-void
.end method

.method public varargs a([I)V
    .locals 1

    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/i;->a([I)Lcom/mg/ola/a/a/b/i;

    move-result-object p1

    iput-object p1, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    return-void
.end method

.method b()V
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->p:Lcom/mg/ola/a/a/b/m;

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    const-class v1, Ljava/lang/Integer;

    if-ne v0, v1, :cond_0

    sget-object v0, Lcom/mg/ola/a/a/b/l;->i:Lcom/mg/ola/a/a/b/m;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->d:Ljava/lang/Class;

    const-class v1, Ljava/lang/Float;

    if-ne v0, v1, :cond_1

    sget-object v0, Lcom/mg/ola/a/a/b/l;->j:Lcom/mg/ola/a/a/b/m;

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    iput-object v0, p0, Lcom/mg/ola/a/a/b/l;->p:Lcom/mg/ola/a/a/b/m;

    :cond_2
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->p:Lcom/mg/ola/a/a/b/m;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->p:Lcom/mg/ola/a/a/b/m;

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/i;->a(Lcom/mg/ola/a/a/b/m;)V

    :cond_3
    return-void
.end method

.method b(Ljava/lang/Object;)V
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->b:Lcom/mg/ola/a/a/a/c;

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/l;->d()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Lcom/mg/ola/a/a/a/c;->a(Ljava/lang/Object;Ljava/lang/Object;)V

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->c:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_1

    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->g:[Ljava/lang/Object;

    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/l;->d()Ljava/lang/Object;

    move-result-object v2

    aput-object v2, v0, v1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->c:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->g:[Ljava/lang/Object;

    invoke-virtual {v0, p1, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    return-object v0
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/l;->a()Lcom/mg/ola/a/a/b/l;

    move-result-object v0

    return-object v0
.end method

.method d()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/l;->q:Ljava/lang/Object;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/l;->e:Lcom/mg/ola/a/a/b/i;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/i;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
