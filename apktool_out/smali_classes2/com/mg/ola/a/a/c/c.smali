.class public abstract Lcom/mg/ola/a/a/c/c;
.super Ljava/lang/Object;


# static fields
.field private static final a:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Landroid/view/View;",
            "Lcom/mg/ola/a/a/c/c;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/util/WeakHashMap;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/WeakHashMap;-><init>(I)V

    sput-object v0, Lcom/mg/ola/a/a/c/c;->a:Ljava/util/WeakHashMap;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/view/View;)Lcom/mg/ola/a/a/c/c;
    .locals 2

    sget-object v0, Lcom/mg/ola/a/a/c/c;->a:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/c/c;

    if-nez v0, :cond_2

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Lcom/mg/ola/a/a/c/e;

    invoke-direct {v0, p0}, Lcom/mg/ola/a/a/c/e;-><init>(Landroid/view/View;)V

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lcom/mg/ola/a/a/c/d;

    invoke-direct {v0, p0}, Lcom/mg/ola/a/a/c/d;-><init>(Landroid/view/View;)V

    goto :goto_0

    :cond_1
    new-instance v0, Lcom/mg/ola/a/a/c/f;

    invoke-direct {v0, p0}, Lcom/mg/ola/a/a/c/f;-><init>(Landroid/view/View;)V

    :goto_0
    sget-object v1, Lcom/mg/ola/a/a/c/c;->a:Ljava/util/WeakHashMap;

    invoke-virtual {v1, p0, v0}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_2
    return-object v0
.end method


# virtual methods
.method public abstract a(F)Lcom/mg/ola/a/a/c/c;
.end method

.method public abstract a(J)Lcom/mg/ola/a/a/c/c;
.end method

.method public abstract a(Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/c/c;
.end method

.method public abstract b(F)Lcom/mg/ola/a/a/c/c;
.end method
