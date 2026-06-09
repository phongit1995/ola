.class public Lchat/ola/vn/network/OlaNetworkService;
.super Landroid/app/Service;

# interfaces
.implements Lchat/ola/vn/network/i;
.implements Lchat/ola/vn/s/b;


# static fields
.field public static b:I = 0x0

.field public static c:I = 0x4d7

.field private static x:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field a:J

.field protected d:Lchat/ola/vn/network/d;

.field protected e:Ljava/net/Socket;

.field protected f:Ljava/lang/String;

.field protected g:Lchat/ola/vn/w/ci;

.field protected h:Lchat/ola/vn/network/e;

.field protected i:Landroid/os/Handler;

.field j:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/network/f;",
            ">;"
        }
    .end annotation
.end field

.field public k:Z

.field private l:I

.field private m:Ljava/lang/Runnable;

.field private n:J

.field private o:J

.field private p:J

.field private q:J

.field private r:J

.field private s:Ljava/lang/String;

.field private t:J

.field private u:Ljava/util/concurrent/ExecutorService;

.field private v:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/s/a;",
            ">;"
        }
    .end annotation
.end field

.field private w:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/s/b;",
            ">;"
        }
    .end annotation
.end field

.field private y:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    const-wide/16 v0, 0x1388

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->a:J

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->f:Ljava/lang/String;

    new-instance v1, Ljava/util/concurrent/CopyOnWriteArrayList;

    invoke-direct {v1}, Ljava/util/concurrent/CopyOnWriteArrayList;-><init>()V

    iput-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/network/OlaNetworkService;->r:J

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->s:Ljava/lang/String;

    iput-wide v1, p0, Lchat/ola/vn/network/OlaNetworkService;->t:J

    const/4 v3, 0x0

    iput-boolean v3, p0, Lchat/ola/vn/network/OlaNetworkService;->k:Z

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->u:Ljava/util/concurrent/ExecutorService;

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    iput-wide v1, p0, Lchat/ola/vn/network/OlaNetworkService;->y:J

    return-void
.end method

.method private A()Lchat/ola/vn/entity/c;
    .locals 3

    new-instance v0, Lchat/ola/vn/entity/c;

    invoke-direct {v0}, Lchat/ola/vn/entity/c;-><init>()V

    sget v1, Lchat/ola/vn/e;->c:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->a(I)V

    sget v1, Lchat/ola/vn/e;->d:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->b(I)V

    sget-object v1, Lchat/ola/vn/h;->f:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->f(Ljava/lang/String;)V

    sget-object v1, Lchat/ola/vn/h;->g:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->d(Ljava/lang/String;)V

    sget-object v1, Lchat/ola/vn/f/a;->n:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->e(Ljava/lang/String;)V

    sget v1, Lchat/ola/vn/h;->r:I

    if-nez v1, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/e;->g()I

    move-result v1

    :cond_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->c(I)V

    const-string v1, "GooglePlay"

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->b(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c/x;->i()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->a(Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SDK_INT="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Landroid/os/Build;->BOARD:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nBOARD="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->BOARD:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_1
    sget-object v2, Landroid/os/Build;->BOARD:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nBRAND="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_2
    sget-object v2, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nCPU_ABI="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_3
    sget-object v2, Landroid/os/Build;->CPU_ABI2:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nCPU_ABI2="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->CPU_ABI2:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_4
    sget-object v2, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nDEVICE="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_5
    sget-object v2, Landroid/os/Build;->DISPLAY:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_6

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nDISPLAY="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->DISPLAY:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_6
    sget-object v2, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_7

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nFINGERPRINT="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_7
    sget-object v2, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_8

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nHARDWARE="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_8
    sget-object v2, Landroid/os/Build;->HOST:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_9

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nHOST="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->HOST:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_9
    sget-object v2, Landroid/os/Build;->ID:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_a

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nID="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->ID:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_a
    sget-object v2, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_b

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nMANUFACTURER="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_b
    sget-object v2, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_c

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nMODEL="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_c
    sget-object v2, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_d

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\nPRODUCT="

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_d
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/c;->c(Ljava/lang/String;)V

    return-object v0
.end method

.method private B()V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/network/OlaNetworkService;->d()V

    return-void
.end method

.method private C()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->i:Landroid/os/Handler;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-wide/16 v0, 0x1388

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->a:J

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->m:Ljava/lang/Runnable;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/network/OlaNetworkService$6;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/OlaNetworkService$6;-><init>(Lchat/ola/vn/network/OlaNetworkService;)V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->m:Ljava/lang/Runnable;

    goto :goto_0

    :cond_1
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->i:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->m:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->i:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->m:Ljava/lang/Runnable;

    iget-wide v2, p0, Lchat/ola/vn/network/OlaNetworkService;->a:J

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method private D()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/s/a;

    invoke-virtual {v1}, Lchat/ola/vn/s/a;->stopWatching()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private E()V
    .locals 5

    new-instance v0, Lchat/ola/vn/entity/aa;

    invoke-direct {v0}, Lchat/ola/vn/entity/aa;-><init>()V

    const-string v1, "lastRoomId"

    iput-object v1, v0, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-string v2, "bmk"

    const/4 v3, 0x1

    new-array v3, v3, [Lchat/ola/vn/entity/aa;

    const/4 v4, 0x0

    aput-object v0, v3, v4

    invoke-virtual {v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    return-void
.end method

.method public static E(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v1, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    invoke-interface {v1, p0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    invoke-interface {v1, p0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    return-void
.end method

.method private F()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->l()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/network/OlaNetworkService;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    return p0
.end method

.method static synthetic a(Lchat/ola/vn/network/OlaNetworkService;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/network/OlaNetworkService;->t:J

    return-wide p1
.end method

.method static synthetic a(Lchat/ola/vn/network/OlaNetworkService;I)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static a()V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/network/OlaNetworkService$1;

    invoke-direct {v0}, Lchat/ola/vn/network/OlaNetworkService$1;-><init>()V

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService$1;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Lchat/ola/vn/entity/m;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/m<",
            "*>;)V"
        }
    .end annotation

    invoke-virtual {p1}, Lchat/ola/vn/entity/m;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p1}, Lchat/ola/vn/k/a;->a(Lchat/ola/vn/entity/m;)Lchat/ola/vn/entity/m;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    iget-wide v2, p1, Lchat/ola/vn/entity/m;->a:J

    iget-boolean p1, p1, Lchat/ola/vn/entity/m;->b:Z

    invoke-virtual {v1, v0, v2, v3, p1}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JZ)V

    :cond_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;SS)V

    return-void
.end method

.method static synthetic a(Ljava/io/File;Z)V
    .locals 0

    invoke-static {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/io/File;Z)V

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 8

    :try_start_0
    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/AccessToken;->isExpired()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;SS)V

    return-void

    :cond_0
    const/4 v0, 0x0

    new-instance v7, Lchat/ola/vn/network/OlaNetworkService$9;

    move-object v1, v7

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    move v6, p4

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService$9;-><init>(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Ljava/lang/String;SS)V

    invoke-static {p0, v0, v7}, Lchat/ola/vn/activity/OlaFacebookActivity;->a(Landroid/content/Context;Landroid/os/Bundle;Lchat/ola/vn/activity/OlaFacebookActivity$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Ljava/util/List;Ljava/lang/String;I)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/s/a;",
            ">;",
            "Ljava/lang/String;",
            "I)V"
        }
    .end annotation

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p2}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {p2}, Lcom/mg/ola/common/d/c;->b(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lchat/ola/vn/s/a;

    invoke-direct {v0, p2}, Lchat/ola/vn/s/a;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Lchat/ola/vn/s/a;->a(Lchat/ola/vn/s/b;)V

    invoke-virtual {v0}, Lchat/ola/vn/s/a;->startWatching()V

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-lez p3, :cond_1

    add-int/lit8 p3, p3, -0x1

    invoke-static {p2}, Lcom/mg/ola/common/d/c;->c(Ljava/lang/String;)[Ljava/io/File;

    move-result-object p2

    if-eqz p2, :cond_1

    array-length v0, p2

    if-lez v0, :cond_1

    const/4 v0, 0x0

    :goto_0
    array-length v1, p2

    if-ge v0, v1, :cond_1

    aget-object v1, p2, v0

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "cache"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    :cond_0
    aget-object v1, p2, v0

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, p1, v1, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/util/List;Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/c;)Z
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/16 v6, 0x3b

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/c;S)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p2, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_0

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/network/f;

    invoke-interface {p3}, Lchat/ola/vn/network/f;->s()V

    goto :goto_0

    :cond_0
    return p1
.end method

.method static synthetic b(Lchat/ola/vn/network/OlaNetworkService;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->t:J

    return-wide v0
.end method

.method static synthetic b(Lchat/ola/vn/network/OlaNetworkService;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/network/OlaNetworkService;->r:J

    return-wide p1
.end method

.method public static b()V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/network/OlaNetworkService$4;

    invoke-direct {v0}, Lchat/ola/vn/network/OlaNetworkService$4;-><init>()V

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService$4;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;SS)V

    return-void
.end method

.method static synthetic b(Ljava/io/File;Z)V
    .locals 0

    invoke-static {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/io/File;Z)V

    return-void
.end method

.method private b(Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 8

    :try_start_0
    invoke-static {}, Lchat/ola/vn/activity/OlaFacebookActivity;->B()Z

    move-result v0

    if-nez v0, :cond_1

    sget-boolean v0, Lchat/ola/vn/activity/OlaFacebookActivity;->f:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    new-instance v7, Lchat/ola/vn/network/OlaNetworkService$10;

    move-object v1, v7

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    move v6, p4

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService$10;-><init>(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Ljava/lang/String;SS)V

    invoke-static {v0, v7}, Lchat/ola/vn/activity/OlaFacebookActivity;->a(Landroid/content/Context;Lchat/ola/vn/activity/OlaFacebookActivity$b;)V

    return-void

    :cond_1
    :goto_0
    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;SS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private b(Ljava/lang/String;[Ljava/lang/String;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ad;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/ad;-><init>(J)V

    iput-object p1, v0, Lchat/ola/vn/network/a/a/ad;->c:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/network/a/a/ad;->d:[Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/network/OlaNetworkService;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/network/OlaNetworkService;->p:J

    return-wide p1
.end method

.method public static c()V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/network/OlaNetworkService$5;

    invoke-direct {v0}, Lchat/ola/vn/network/OlaNetworkService$5;-><init>()V

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Void;

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService$5;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic c(Lchat/ola/vn/network/OlaNetworkService;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->B()V

    return-void
.end method

.method private static c(Ljava/io/File;Z)V
    .locals 14

    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object p0

    if-eqz p0, :cond_8

    array-length v0, p0

    if-lez v0, :cond_8

    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    const-wide/16 v1, 0x0

    array-length v3, p0

    const/4 v4, 0x0

    move-wide v5, v1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v3, :cond_4

    aget-object v2, p0, v1

    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v7

    add-long v9, v5, v7

    move-wide v5, v9

    goto :goto_3

    :cond_0
    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_3

    array-length v7, v2

    if-lez v7, :cond_3

    array-length v7, v2

    move-wide v8, v5

    const/4 v5, 0x0

    :goto_1
    if-ge v5, v7, :cond_2

    aget-object v6, v2, v5

    invoke-virtual {v6}, Ljava/io/File;->isFile()Z

    move-result v10

    if-eqz v10, :cond_1

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v6}, Ljava/io/File;->length()J

    move-result-wide v10

    add-long v12, v8, v10

    move-wide v8, v12

    goto :goto_2

    :cond_1
    invoke-static {v6}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    :cond_2
    move-wide v5, v8

    :cond_3
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_4
    new-instance p0, Lchat/ola/vn/e/b;

    invoke-direct {p0}, Lchat/ola/vn/e/b;-><init>()V

    invoke-static {v0, p0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_4
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    if-nez p1, :cond_5

    const-wide/32 v1, 0x1900000

    cmp-long v3, v5, v1

    if-lez v3, :cond_8

    :cond_5
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v1

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_6

    invoke-static {v0}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    goto :goto_5

    :cond_6
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_7

    sub-long v3, v5, v1

    move-wide v5, v3

    :cond_7
    :goto_5
    invoke-interface {p0}, Ljava/util/Iterator;->remove()V

    goto :goto_4

    :cond_8
    return-void
.end method

.method private c(Ljava/lang/String;Ljava/lang/String;SS)V
    .locals 6

    :try_start_0
    new-instance v3, Landroid/os/Bundle;

    invoke-direct {v3}, Landroid/os/Bundle;-><init>()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance p3, Lorg/json/JSONObject;

    invoke-direct {p3}, Lorg/json/JSONObject;-><init>()V

    const/16 v0, 0xb

    if-ne p4, v0, :cond_0

    return-void

    :cond_0
    const/16 v0, 0xa

    if-ne p4, v0, :cond_1

    const-string p4, "value"

    const-string v0, "SELF"

    :goto_0
    invoke-virtual {p3, p4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_1

    :cond_1
    const-string p4, "value"

    const-string v0, "EVERYONE"

    goto :goto_0

    :goto_1
    const-string p4, "privacy"

    invoke-virtual {p3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v3, p4, p3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const-string p3, ""

    invoke-static {p1, p3}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const-string p3, "message"

    invoke-virtual {v3, p3, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    invoke-static {p2}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result p1

    const/4 p3, 0x1

    if-ne p1, p3, :cond_3

    const-string p1, "picture"

    invoke-static {p2}, Lchat/ola/vn/entity/i;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v3, p1, p2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    new-instance p1, Lcom/facebook/GraphRequest;

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v1

    const-string v2, "/me/feed"

    sget-object v4, Lcom/facebook/HttpMethod;->POST:Lcom/facebook/HttpMethod;

    new-instance v5, Lchat/ola/vn/network/OlaNetworkService$11;

    invoke-direct {v5, p0}, Lchat/ola/vn/network/OlaNetworkService$11;-><init>(Lchat/ola/vn/network/OlaNetworkService;)V

    move-object v0, p1

    invoke-direct/range {v0 .. v5}, Lcom/facebook/GraphRequest;-><init>(Lcom/facebook/AccessToken;Ljava/lang/String;Landroid/os/Bundle;Lcom/facebook/HttpMethod;Lcom/facebook/GraphRequest$Callback;)V

    invoke-virtual {p1}, Lcom/facebook/GraphRequest;->executeAsync()Lcom/facebook/GraphRequestAsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/network/OlaNetworkService;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->r:J

    return-wide v0
.end method

.method static synthetic d(Lchat/ola/vn/network/OlaNetworkService;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/network/OlaNetworkService;->q:J

    return-wide p1
.end method

.method private d(I)Ljava/lang/String;
    .locals 0

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    const-string p1, ""

    return-object p1

    :pswitch_1
    const-string p1, "STATE_ONLINE"

    return-object p1

    :pswitch_2
    const-string p1, "STATE_AUTHENTICATING"

    return-object p1

    :pswitch_3
    const-string p1, "STATE_READY"

    return-object p1

    :pswitch_4
    const-string p1, "STATE_CONNECTED"

    return-object p1

    :pswitch_5
    const-string p1, "STATE_CONNECTING"

    return-object p1

    :pswitch_6
    const-string p1, "STATE_NOT_CONNECTED"

    return-object p1

    :pswitch_7
    const-string p1, "STATE_NO_NETWORK"

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private static d(Ljava/io/File;Z)V
    .locals 16

    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-virtual/range {p0 .. p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v2

    if-eqz v2, :cond_7

    array-length v3, v2

    if-lez v3, :cond_7

    array-length v3, v2

    const/4 v4, 0x0

    const/4 v5, 0x0

    :goto_0
    if-ge v5, v3, :cond_7

    aget-object v6, v2, v5

    invoke-virtual {v6}, Ljava/io/File;->isFile()Z

    move-result v7

    const-wide/32 v8, 0x5265c00

    if-eqz v7, :cond_2

    invoke-virtual {v6}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    if-eqz v7, :cond_6

    const-string v10, ".ovatar."

    invoke-virtual {v7, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    const-string v10, ".cover."

    invoke-virtual {v7, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    const-string v10, ".covatar."

    invoke-virtual {v7, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    const-string v10, ".ccover."

    invoke-virtual {v7, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_0

    const-string v10, ".thumb."

    invoke-virtual {v7, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_6

    :cond_0
    if-nez p1, :cond_1

    :try_start_0
    sget-boolean v7, Lchat/ola/vn/h;->I:Z

    if-nez v7, :cond_1

    invoke-virtual {v6}, Ljava/io/File;->lastModified()J

    move-result-wide v10

    const/4 v7, 0x0

    sub-long v12, v0, v10

    cmp-long v7, v12, v8

    if-ltz v7, :cond_6

    :cond_1
    invoke-virtual {v6}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :catch_0
    :try_start_1
    invoke-virtual {v6}, Ljava/io/File;->delete()Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3

    goto :goto_3

    :cond_2
    invoke-virtual {v6}, Ljava/io/File;->isDirectory()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-virtual {v6}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v6

    if-eqz v6, :cond_6

    array-length v7, v6

    if-lez v7, :cond_6

    array-length v7, v6

    const/4 v10, 0x0

    :goto_1
    if-ge v10, v7, :cond_6

    aget-object v11, v6, v10

    invoke-virtual {v11}, Ljava/io/File;->isFile()Z

    move-result v12

    if-eqz v12, :cond_5

    invoke-virtual {v11}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v12

    const-string v13, ".ovatar."

    invoke-virtual {v12, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v13

    if-nez v13, :cond_3

    const-string v13, ".cover."

    invoke-virtual {v12, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v13

    if-nez v13, :cond_3

    const-string v13, ".covatar."

    invoke-virtual {v12, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v13

    if-nez v13, :cond_3

    const-string v13, ".ccover."

    invoke-virtual {v12, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v13

    if-nez v13, :cond_3

    const-string v13, ".thumb."

    invoke-virtual {v12, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_5

    :cond_3
    if-nez p1, :cond_4

    :try_start_2
    sget-boolean v12, Lchat/ola/vn/h;->I:Z

    if-nez v12, :cond_4

    invoke-virtual {v11}, Ljava/io/File;->lastModified()J

    move-result-wide v12

    const/4 v14, 0x0

    sub-long v14, v0, v12

    cmp-long v12, v14, v8

    if-ltz v12, :cond_5

    :cond_4
    invoke-virtual {v11}, Ljava/io/File;->delete()Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    :catch_1
    :try_start_3
    invoke-virtual {v11}, Ljava/io/File;->delete()Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_5
    :goto_2
    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    :catch_3
    :cond_6
    :goto_3
    add-int/lit8 v5, v5, 0x1

    goto/16 :goto_0

    :cond_7
    return-void
.end method

.method static synthetic e(Lchat/ola/vn/network/OlaNetworkService;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->n:J

    return-wide v0
.end method

.method static synthetic f(Lchat/ola/vn/network/OlaNetworkService;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->o:J

    return-wide v0
.end method

.method static synthetic g(Lchat/ola/vn/network/OlaNetworkService;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->p:J

    return-wide v0
.end method

.method static synthetic h(Lchat/ola/vn/network/OlaNetworkService;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->q:J

    return-wide v0
.end method

.method static synthetic i(Lchat/ola/vn/network/OlaNetworkService;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->C()V

    return-void
.end method

.method static synthetic j(Lchat/ola/vn/network/OlaNetworkService;)Ljava/lang/ref/WeakReference;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/network/OlaNetworkService;->w:Ljava/lang/ref/WeakReference;

    return-object p0
.end method

.method private m(Ljava/lang/String;Ljava/lang/String;S)Z
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/network/OlaNetworkService;->y:J

    sub-long v4, v0, v2

    const-wide/16 v0, 0xc8

    cmp-long v2, v4, v0

    if-gez v2, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->y:J

    new-instance v0, Lchat/ola/vn/network/a/a/ag;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/ag;-><init>(J)V

    iput-object p1, v0, Lchat/ola/vn/network/a/a/ag;->c:Ljava/lang/String;

    iput-object p2, v0, Lchat/ola/vn/network/a/a/ag;->d:Ljava/lang/String;

    iput-short p3, v0, Lchat/ola/vn/network/a/a/ag;->e:S

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    const/4 p1, 0x1

    return p1
.end method

.method static synthetic y()Ljava/util/List;
    .locals 1

    sget-object v0, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    return-object v0
.end method

.method private z()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    invoke-static {}, Lchat/ola/vn/d;->b()Ljava/util/List;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_1

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    invoke-direct {p0, v3, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/util/List;Ljava/lang/String;I)V

    goto :goto_0

    :cond_1
    invoke-static {}, Lchat/ola/vn/d;->c()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_2

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    invoke-direct {p0, v3, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/util/List;Ljava/lang/String;I)V

    goto :goto_1

    :cond_2
    invoke-static {}, Lchat/ola/vn/d;->d()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_3

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_3

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/OlaNetworkService;->v:Ljava/util/List;

    invoke-direct {p0, v3, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/util/List;Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method


# virtual methods
.method public A(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    sget-object v1, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    sget-object p1, Lchat/ola/vn/network/OlaNetworkService;->x:Ljava/util/List;

    invoke-interface {p1, v2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    monitor-exit v0

    return-void

    :cond_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    new-instance v0, Lchat/ola/vn/network/OlaNetworkService$3;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/network/OlaNetworkService$3;-><init>(Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    const-wide/16 v1, 0x2710

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return-void

    :catchall_0
    move-exception p1

    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw p1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    return-void
.end method

.method public B(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/e;->i(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public C(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;)V

    return-void
.end method

.method public D(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;)V

    return-void
.end method

.method public a(DILjava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/a/a/l$a;)V
    .locals 9

    invoke-static {p4}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p5}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/l;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    move-object v1, v0

    move-wide v2, p1

    move v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-direct/range {v1 .. v8}, Lchat/ola/vn/network/a/a/l;-><init>(DILjava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p6}, Lchat/ola/vn/network/a/a/l;->a(Lchat/ola/vn/network/a/a/l$a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    :cond_1
    return-void
.end method

.method a(I)V
    .locals 3

    iget v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    if-ne v0, p1, :cond_0

    return-void

    :cond_0
    iput p1, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    const-string v0, "OlaNetworkService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "-------SET STATE: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-direct {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->n:J

    const/4 v0, 0x1

    if-eq p1, v0, :cond_1

    const-wide/16 v0, 0x0

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->z()V

    const/4 p1, 0x0

    sput p1, Lchat/ola/vn/r/a/e;->b:I

    sput-wide v0, Lchat/ola/vn/r/a/e;->c:J

    const/4 v2, 0x0

    sput-object v2, Lchat/ola/vn/r/a/e;->a:Ljava/lang/String;

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->o:J

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->p:J

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->q:J

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->F()V

    invoke-virtual {p0, v2, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;S)V

    return-void

    :pswitch_1
    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->t:J

    return-void

    :pswitch_2
    invoke-static {}, Lchat/ola/vn/h;->g()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/network/OlaNetworkService;->e()V

    :cond_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x5
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(J)V
    .locals 8

    const-string v1, "@113 topme"

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v0, p0

    move-wide v2, p1

    invoke-virtual/range {v0 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public a(JJS)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-wide v1, p1

    move-wide v3, p3

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(JJS)V

    return-void
.end method

.method public a(JLchat/ola/vn/p/c;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/r;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/r;-><init>(JJ)V

    iput-object p3, v0, Lchat/ola/vn/network/a/a/r;->c:Lchat/ola/vn/p/c;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(JLjava/lang/String;)V
    .locals 10

    invoke-static {p3}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 top #"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v2, p0

    move-wide v4, p1

    invoke-virtual/range {v2 .. v9}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public a(JLjava/lang/String;Ljava/lang/String;S)V
    .locals 7

    const/4 v3, 0x0

    move-object v0, p0

    move-wide v1, p1

    move-object v4, p3

    move-object v5, p4

    move v6, p5

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(JZLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public a(JLjava/lang/String;S)V
    .locals 1

    :try_start_0
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-nez p4, :cond_0

    return-void

    :cond_0
    invoke-static {p3}, Lchat/ola/vn/util/m;->o(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/i/i;->a()V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(JLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(JS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(JS)V

    return-void
.end method

.method public a(JZ)V
    .locals 3

    if-eqz p3, :cond_0

    const/4 p3, 0x2

    goto :goto_0

    :cond_0
    const/4 p3, 0x0

    :goto_0
    const-string v0, "me"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, p1, p3}, Lchat/ola/vn/network/OlaNetworkService;->m(Ljava/lang/String;Ljava/lang/String;S)Z

    return-void
.end method

.method public a(JZLjava/lang/String;Ljava/lang/String;S)V
    .locals 8

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p3}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-wide v2, p1

    move v4, p3

    move-object v5, p4

    move-object v6, p5

    move v7, p6

    invoke-virtual/range {v1 .. v7}, Lchat/ola/vn/w/ci;->a(JZLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public a(JZS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(JZS)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/v;Lchat/ola/vn/p/m;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/aa;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/aa;-><init>(Lchat/ola/vn/entity/v;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/aa;->a(Lchat/ola/vn/p/m;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const-string v1, "Friends"

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->e(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;)V

    return-void
.end method

.method public a(Lchat/ola/vn/network/a/a/l$a;)V
    .locals 8

    :try_start_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const-wide/high16 v2, 0x4039000000000000L    # 25.0

    const/4 v4, 0x1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v5

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v6

    move-object v1, p0

    move-object v7, p1

    invoke-virtual/range {v1 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(DILjava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/a/a/l$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Lchat/ola/vn/network/f;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_2

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/network/f;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/network/g;)V
    .locals 2

    const/4 v0, 0x3

    iput v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->n:J

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    invoke-interface {v1}, Lchat/ola/vn/network/f;->p()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    iget-object v0, p1, Lchat/ola/vn/network/g;->f:Ljava/net/Socket;

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->e:Ljava/net/Socket;

    iget-object v0, p1, Lchat/ola/vn/network/g;->b:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->f:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p1}, Lchat/ola/vn/network/g;->b()Ljava/io/InputStream;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/ci;->a(Ljava/io/InputStream;)V

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p1}, Lchat/ola/vn/network/g;->c()Ljava/io/OutputStream;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/ci;->a(Ljava/io/OutputStream;)V

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->A()Lchat/ola/vn/entity/c;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/entity/c;)V

    iget-object p1, p1, Lchat/ola/vn/network/g;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/ci;->a(Z)V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/ci;->a(Z)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->u:Ljava/util/concurrent/ExecutorService;

    if-nez p1, :cond_2

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->u:Ljava/util/concurrent/ExecutorService;

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->u:Ljava/util/concurrent/ExecutorService;

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->p()Lchat/ola/vn/w/dq;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Lchat/ola/vn/p/m;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/z;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/z;-><init>(J)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/a/a/z;->a(Lchat/ola/vn/p/m;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Lchat/ola/vn/p/n;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ab;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/ab;-><init>(J)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/a/a/ab;->a(Lchat/ola/vn/p/n;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Lchat/ola/vn/p/p;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/am;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/am;-><init>(J)V

    iput-object p1, v0, Lchat/ola/vn/network/a/a/am;->c:Lchat/ola/vn/p/p;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Lchat/ola/vn/s/b;)V
    .locals 1

    if-eqz p1, :cond_0

    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->w:Ljava/lang/ref/WeakReference;

    return-void

    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->w:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/o;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/o;-><init>(Ljava/lang/String;J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;BLjava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;BLjava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;ILchat/ola/vn/p/a;)V
    .locals 8

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/k;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    move-object v1, v0

    move-object v2, p1

    move v3, p2

    invoke-direct/range {v1 .. v7}, Lchat/ola/vn/network/a/a/k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/network/a/a/k;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;ILchat/ola/vn/p/k;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/u;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/u;-><init>(Ljava/lang/String;IJ)V

    iput-object p3, v0, Lchat/ola/vn/network/a/a/u;->e:Lchat/ola/vn/p/k;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;ISS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;ISS)V

    return-void
.end method

.method public a(Ljava/lang/String;JLchat/ola/vn/p/a;)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/a/a/h;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object v0, v6

    move-object v1, p1

    move-wide v2, p2

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/a/a/h;-><init>(Ljava/lang/String;JJ)V

    invoke-virtual {v6, p4}, Lchat/ola/vn/network/a/a/h;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;S)V
    .locals 9

    const/4 v6, 0x2

    move-object v0, p0

    move-object v1, p1

    move-wide v2, p2

    move-object v4, p4

    move v5, p5

    move-object v7, p6

    move/from16 v8, p7

    invoke-virtual/range {v0 .. v8}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;S)V
    .locals 10

    move-object v0, p0

    move-object v2, p1

    move-object v5, p4

    move v6, p5

    move/from16 v1, p6

    move/from16 v9, p8

    packed-switch v1, :pswitch_data_0

    iget-object v3, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    int-to-byte v8, v1

    move-object v1, v3

    move-wide v3, p2

    move-object/from16 v7, p7

    invoke-virtual/range {v1 .. v9}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;BS)V

    return-void

    :pswitch_0
    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v1, v2, v5, v6, v9}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;SS)V

    return-void

    :pswitch_1
    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v1, v2, v5, v6, v9}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;SS)V

    return-void

    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Ljava/lang/String;JS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JS)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;)V
    .locals 3

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/aj;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/aj;-><init>(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/network/a/a/al$a;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/al;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/al;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/al;->a(Lchat/ola/vn/network/a/a/al$a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/network/a/a/p$a;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/p;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/p;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/p;->a(Lchat/ola/vn/network/a/a/p$a;)V

    new-instance p1, Lchat/ola/vn/l/c;

    invoke-direct {p1}, Lchat/ola/vn/l/c;-><init>()V

    invoke-virtual {p1, v0}, Lchat/ola/vn/l/c;->a(Lchat/ola/vn/network/a/a/p;)V

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Void;

    invoke-virtual {p1, p2}, Lchat/ola/vn/l/c;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/a;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/b;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/b;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/b;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/b;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/q;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/q;-><init>(Ljava/lang/String;J)V

    iput-object p2, v0, Lchat/ola/vn/network/a/a/q;->c:Lchat/ola/vn/p/b;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/d;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/w;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/w;-><init>(Ljava/lang/String;J)V

    iput-object p2, v0, Lchat/ola/vn/network/a/a/w;->d:Lchat/ola/vn/p/d;

    const/16 p1, 0x14

    new-array p1, p1, [Ljava/lang/String;

    const-string p2, "name"

    const/4 v1, 0x0

    aput-object p2, p1, v1

    const-string p2, "gender"

    const/4 v1, 0x1

    aput-object p2, p1, v1

    const-string p2, "birthday"

    const/4 v1, 0x2

    aput-object p2, p1, v1

    const-string p2, "registerMs"

    const/4 v1, 0x3

    aput-object p2, p1, v1

    const-string p2, "socialLinkType"

    const/4 v1, 0x4

    aput-object p2, p1, v1

    const-string p2, "noFans"

    const/4 v1, 0x5

    aput-object p2, p1, v1

    const-string p2, "noFriends"

    const/4 v1, 0x6

    aput-object p2, p1, v1

    const-string p2, "statusMessage"

    const/4 v1, 0x7

    aput-object p2, p1, v1

    const-string p2, "cared"

    const/16 v1, 0x8

    aput-object p2, p1, v1

    const-string p2, "isFan"

    const/16 v1, 0x9

    aput-object p2, p1, v1

    const-string p2, "blocked"

    const/16 v1, 0xa

    aput-object p2, p1, v1

    const-string p2, "boxSpouse"

    const/16 v1, 0xb

    aput-object p2, p1, v1

    const-string p2, "phone"

    const/16 v1, 0xc

    aput-object p2, p1, v1

    const-string p2, "friends"

    const/16 v1, 0xd

    aput-object p2, p1, v1

    const-string p2, "fans"

    const/16 v1, 0xe

    aput-object p2, p1, v1

    const-string p2, "noMedias"

    const/16 v1, 0xf

    aput-object p2, p1, v1

    const-string p2, "medias"

    const/16 v1, 0x10

    aput-object p2, p1, v1

    const-string p2, "lastActiveAgo"

    const/16 v1, 0x11

    aput-object p2, p1, v1

    const-string p2, "vip"

    const/16 v1, 0x12

    aput-object p2, p1, v1

    const-string p2, "like"

    const/16 v1, 0x13

    aput-object p2, p1, v1

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/a/a/w;->a([Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/i;)V
    .locals 3

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v0

    :catch_0
    new-instance v0, Lchat/ola/vn/network/a/a/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/a;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/a;->a(Lchat/ola/vn/p/i;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/j;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/m;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/m;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/m;->a(Lchat/ola/vn/p/j;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/l;)V
    .locals 3

    :try_start_0
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "rss://"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "rss://"

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v0

    :catch_0
    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/x;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/x;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/x;->a(Lchat/ola/vn/p/l;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/n;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ab;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/ab;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/ab;->a(Lchat/ola/vn/p/n;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/p/o;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ac;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/ac;-><init>(Ljava/lang/String;J)V

    iput-object p2, v0, Lchat/ola/vn/network/a/a/ac;->c:Lchat/ola/vn/p/o;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, v1}, Lchat/ola/vn/w/ci;->f(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;BLjava/lang/String;S)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move-object v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;BLjava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;IJS)V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object v2, p2

    move v3, p3

    move-wide v4, p4

    move v6, p6

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;IJS)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/p/a;)V
    .locals 9

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/g;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v5

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    move-object v1, v0

    move-object v2, p1

    move-object v3, p2

    move v4, p3

    invoke-direct/range {v1 .. v8}, Lchat/ola/vn/network/a/a/g;-><init>(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p4}, Lchat/ola/vn/network/a/a/g;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;JS)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    move-object v2, p2

    move-wide v3, p3

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;JS)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/a/a/ai$a;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ai;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/ai;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/network/a/a/ai;->a(Lchat/ola/vn/network/a/a/ai$a;)V

    new-instance p1, Lchat/ola/vn/l/j;

    invoke-direct {p1}, Lchat/ola/vn/l/j;-><init>()V

    invoke-virtual {p1, v0}, Lchat/ola/vn/l/j;->a(Lchat/ola/vn/network/a/a/ai;)V

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Void;

    invoke-virtual {p1, p2}, Lchat/ola/vn/l/j;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/q;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/v;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/v;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/network/a/a/v;->a(Lchat/ola/vn/p/q;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v5, 0x0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;[B)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/p/a;)V
    .locals 8

    invoke-static {p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p3}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/k;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    move-object v1, v0

    move-object v2, p1

    move v3, p4

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v1 .. v7}, Lchat/ola/vn/network/a/a/k;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p5}, Lchat/ola/vn/network/a/a/k;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/a/a/i;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object v0, v6

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/a/a/i;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v6, p4}, Lchat/ola/vn/network/a/a/i;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/q;)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/a/a/n;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object v0, v6

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/a/a/n;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v6, p4}, Lchat/ola/vn/network/a/a/n;->a(Lchat/ola/vn/p/q;)V

    invoke-direct {p0, v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;BS)V
    .locals 10

    move-object v0, p0

    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p8

    invoke-virtual/range {v1 .. v9}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;BS)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/String;BS)V
    .locals 11

    move-object v0, p0

    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object/from16 v6, p5

    move-object/from16 v7, p6

    move-object/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    invoke-virtual/range {v1 .. v10}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/String;BS)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 7

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-nez p4, :cond_0

    return-void

    :cond_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->o(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/i/i;->a()V

    return-void

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v6, 0x0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lchat/ola/vn/p/a;",
            ")V"
        }
    .end annotation

    new-instance v8, Lchat/ola/vn/network/a/a/j;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    move-object v0, v8

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/network/a/a/j;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v8, p6}, Lchat/ola/vn/network/a/a/j;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v8}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->h(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    .locals 8

    const/4 v4, 0x2

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move-object v5, p4

    move v7, p5

    invoke-virtual/range {v0 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SSLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;SSLjava/lang/String;Ljava/lang/String;S)V
    .locals 14

    move-object v0, p0

    move-object v9, p1

    move-object/from16 v10, p2

    move/from16 v11, p3

    move/from16 v12, p4

    move/from16 v8, p7

    :try_start_0
    invoke-static {v9}, Lchat/ola/vn/util/m;->o(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    return-void

    :catch_0
    :cond_0
    and-int/lit16 v1, v12, 0x3fff

    int-to-short v13, v1

    packed-switch v13, :pswitch_data_0

    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    int-to-byte v7, v13

    move-object v2, v9

    move-object v3, v10

    move v4, v11

    move-object/from16 v5, p5

    move-object/from16 v6, p6

    invoke-virtual/range {v1 .. v8}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/lang/String;BS)V

    goto :goto_0

    :pswitch_0
    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v1, v9, v10, v11, v8}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;SS)V

    goto :goto_0

    :pswitch_1
    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v1, v9, v10, v11, v8}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;SS)V

    :goto_0
    const/16 v1, 0x4000

    and-int/lit16 v2, v12, 0x4000

    if-ne v2, v1, :cond_1

    invoke-direct {v0, v9, v10, v11, v13}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SS)V

    :cond_1
    return-void

    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;ZLchat/ola/vn/p/q;)V
    .locals 7

    new-instance v6, Lchat/ola/vn/network/a/a/y;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    move-object v0, v6

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/network/a/a/y;-><init>(Ljava/lang/String;Ljava/lang/String;ZJ)V

    invoke-virtual {v6, p4}, Lchat/ola/vn/network/a/a/y;->a(Lchat/ola/vn/p/q;)V

    invoke-direct {p0, v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 5

    if-eqz p3, :cond_4

    array-length v0, p3

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p3

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    array-length v1, p3

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p3, v2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p3

    if-nez p3, :cond_3

    return-void

    :cond_3
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p3

    new-array p3, p3, [Ljava/lang/String;

    invoke-interface {v0, p3}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p3

    check-cast p3, [Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    :cond_4
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lchat/ola/vn/p/a;",
            ")V"
        }
    .end annotation

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/d;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v6

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    move-object v1, v0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v1 .. v9}, Lchat/ola/vn/network/a/a/d;-><init>(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p5}, Lchat/ola/vn/network/a/a/d;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;S)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const-wide/16 v1, 0x0

    invoke-virtual {v0, p1, v1, v2, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JS)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SLjava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;S)V
    .locals 1

    invoke-static {p3}, Lchat/ola/vn/message/d;->g(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;SZ)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;SZ)V

    return-void
.end method

.method public a(Ljava/lang/String;S[I[I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;S[I[I)V

    return-void
.end method

.method public a(Ljava/lang/String;Z)V
    .locals 0

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p2, p1}, Lchat/ola/vn/w/ci;->e(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/util/c/a;->u:Landroid/net/Uri;

    invoke-static {p1, p2}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p2, p1}, Lchat/ola/vn/w/ci;->f(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;ZS)V
    .locals 0

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/w/ci;->h(Ljava/lang/String;S)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/w/ci;->i(Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;[BS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[BS)V

    return-void
.end method

.method public a(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    return-void
.end method

.method public varargs a(Ljava/lang/String;[Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V
    .locals 3

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/network/a/a/w;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/w;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/a/a/w;->c(Ljava/lang/String;)V

    iput-object p3, v0, Lchat/ola/vn/network/a/a/w;->d:Lchat/ola/vn/p/d;

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/w;->a([Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, p3, v1}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_1

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    const-string p1, "me"

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Ljava/lang/String;)V

    :cond_2
    return-void
.end method

.method public a(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->a(S)V

    return-void
.end method

.method public a(SS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->a(SS)V

    return-void
.end method

.method public a(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->j()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->b(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a([Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->c([Ljava/lang/String;)V

    return-void
.end method

.method public a([Ljava/lang/String;[Ljava/lang/String;)V
    .locals 3

    if-eqz p1, :cond_1

    array-length v0, p1

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const-string v1, "Friends"

    invoke-virtual {v0, v1, p1, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)V

    const/4 p2, 0x0

    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    aget-object v1, p1, v0

    const/4 v2, 0x1

    invoke-virtual {p0, v1, v2, p2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method

.method public a([Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a([Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 8

    const/16 v0, 0x40

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v0

    :catch_0
    :cond_0
    move-object v3, p1

    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/network/OlaNetworkService;->g()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->A()Lchat/ola/vn/entity/c;

    move-result-object v7

    move-object v2, p0

    move-object v4, p2

    move-object v5, p3

    move-object v6, p4

    invoke-direct/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/c;)Z

    move-result p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    if-eqz p1, :cond_1

    const/4 p1, 0x1

    return p1

    :catch_1
    :cond_1
    return v1
.end method

.method public b(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->a(I)V

    return-void
.end method

.method public b(J)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->a(J)V

    return-void
.end method

.method public b(JLchat/ola/vn/p/c;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/s;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/s;-><init>(JJ)V

    iput-object p3, v0, Lchat/ola/vn/network/a/a/s;->c:Lchat/ola/vn/p/c;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public b(JLjava/lang/String;)V
    .locals 10

    invoke-static {p3}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 all #"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v2, p0

    move-wide v4, p1

    invoke-virtual/range {v2 .. v9}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public b(JLjava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->b(JLjava/lang/String;S)V

    return-void
.end method

.method public b(JS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->b(JS)V

    return-void
.end method

.method public b(Lchat/ola/vn/network/f;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-nez v0, :cond_1

    return-void

    :cond_1
    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_3

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/network/f;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    return-void

    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/network/OlaNetworkService;->g()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x6

    invoke-virtual {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->A()Lchat/ola/vn/entity/c;

    move-result-object v1

    const/16 v2, 0x3a

    invoke-virtual {v0, p1, v1, v2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Lchat/ola/vn/entity/c;S)V

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/network/f;

    invoke-interface {v0}, Lchat/ola/vn/network/f;->t()V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;S)V
    .locals 10

    move-object v0, p0

    move-object v2, p1

    move-object v5, p4

    move v6, p5

    move/from16 v1, p6

    move/from16 v9, p8

    packed-switch v1, :pswitch_data_0

    iget-object v3, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    int-to-byte v8, v1

    move-object v1, v3

    move-wide v3, p2

    move-object/from16 v7, p7

    invoke-virtual/range {v1 .. v9}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;BS)V

    return-void

    :pswitch_0
    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v1, v2, v5, v6, v9}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;SS)V

    return-void

    :pswitch_1
    iget-object v1, v0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v1, v2, v5, v6, v9}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;SS)V

    return-void

    :pswitch_data_0
    .packed-switch 0xa
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/p/a;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/f;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/f;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/f;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/p/b;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/q;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/q;-><init>(J)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/a/a/q;->c(Ljava/lang/String;)V

    iput-object p2, v0, Lchat/ola/vn/network/a/a/q;->c:Lchat/ola/vn/p/b;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/p/d;)V
    .locals 3

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "lastActiveAgo"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    invoke-virtual {p0, p1, v0, p2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const-string v1, "Friends"

    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/String;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    new-array v5, v2, [Ljava/lang/String;

    aput-object p2, v5, v4

    invoke-virtual {v0, v1, v3, v5}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)V

    invoke-virtual {p0, p1, v2, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V
    .locals 9

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/c;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v5

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    move-object v1, v0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    invoke-direct/range {v1 .. v8}, Lchat/ola/vn/network/a/a/c;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    invoke-virtual {v0, p4}, Lchat/ola/vn/network/a/a/c;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    :cond_1
    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    .locals 6

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    move-object v2, p2

    move v3, p3

    move-object v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/lang/String;S)V
    .locals 3

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    :cond_0
    new-instance v0, Lchat/ola/vn/network/a/a/w;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/w;-><init>(Ljava/lang/String;J)V

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->h:Lchat/ola/vn/network/e;

    iput-object p1, v0, Lchat/ola/vn/network/a/a/w;->c:Lchat/ola/vn/p/g;

    iput-short p2, v0, Lchat/ola/vn/network/a/a/w;->e:S

    const/16 p1, 0x14

    new-array p1, p1, [Ljava/lang/String;

    const/4 p2, 0x0

    const-string v1, "name"

    aput-object v1, p1, p2

    const/4 p2, 0x1

    const-string v1, "gender"

    aput-object v1, p1, p2

    const/4 p2, 0x2

    const-string v1, "birthday"

    aput-object v1, p1, p2

    const/4 p2, 0x3

    const-string v1, "registerMs"

    aput-object v1, p1, p2

    const/4 p2, 0x4

    const-string v1, "socialLinkType"

    aput-object v1, p1, p2

    const/4 p2, 0x5

    const-string v1, "noFans"

    aput-object v1, p1, p2

    const/4 p2, 0x6

    const-string v1, "noFriends"

    aput-object v1, p1, p2

    const/4 p2, 0x7

    const-string v1, "statusMessage"

    aput-object v1, p1, p2

    const/16 p2, 0x8

    const-string v1, "cared"

    aput-object v1, p1, p2

    const/16 p2, 0x9

    const-string v1, "isFan"

    aput-object v1, p1, p2

    const/16 p2, 0xa

    const-string v1, "blocked"

    aput-object v1, p1, p2

    const/16 p2, 0xb

    const-string v1, "boxSpouse"

    aput-object v1, p1, p2

    const/16 p2, 0xc

    const-string v1, "phone"

    aput-object v1, p1, p2

    const/16 p2, 0xd

    const-string v1, "friends"

    aput-object v1, p1, p2

    const/16 p2, 0xe

    const-string v1, "fans"

    aput-object v1, p1, p2

    const/16 p2, 0xf

    const-string v1, "noMedias"

    aput-object v1, p1, p2

    const/16 p2, 0x10

    const-string v1, "medias"

    aput-object v1, p1, p2

    const/16 p2, 0x11

    const-string v1, "lastActiveAgo"

    aput-object v1, p1, p2

    const/16 p2, 0x12

    const-string v1, "vip"

    aput-object v1, p1, p2

    const/16 p2, 0x13

    const-string v1, "like"

    aput-object v1, p1, p2

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/a/a/w;->a([Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public b(Ljava/lang/String;SLjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;SLjava/lang/String;)V

    return-void
.end method

.method public b(Ljava/lang/String;Z)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ah;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/ah;-><init>(Ljava/lang/String;ZJ)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result p1

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/util/c/a;->u:Landroid/net/Uri;

    invoke-static {p1, p2}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;[BS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;[BS)V

    return-void
.end method

.method public b(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;[Lchat/ola/vn/entity/aa;S)V

    return-void
.end method

.method public b(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/w;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/w;-><init>(Ljava/lang/String;J)V

    iput-object p3, v0, Lchat/ola/vn/network/a/a/w;->d:Lchat/ola/vn/p/d;

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/w;->a([Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public b(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/w/ci;->a(Ljava/util/List;Z)V

    return-void
.end method

.method public b(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->b(S)V

    return-void
.end method

.method public b([Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->d([Ljava/lang/String;)V

    return-void
.end method

.method public b([Ljava/lang/String;[Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, v1}, Lchat/ola/vn/w/ci;->b([Ljava/lang/String;[Ljava/lang/String;S)V

    return-void
.end method

.method public b(JZ)Z
    .locals 3

    if-eqz p3, :cond_0

    const/4 p3, 0x1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->u:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    goto :goto_0

    :cond_0
    const/4 p3, 0x0

    :cond_1
    :goto_0
    const-string v0, "me"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, p1, p3}, Lchat/ola/vn/network/OlaNetworkService;->m(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result p1

    return p1
.end method

.method public c(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->b(I)V

    return-void
.end method

.method public c(J)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->b(J)V

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->E()V

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object p1

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object p2, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/message/g;->a(J)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_0

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->c()Lchat/ola/vn/c;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->G()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->v()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public c(JLchat/ola/vn/p/c;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/t;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, p2, v1, v2}, Lchat/ola/vn/network/a/a/t;-><init>(JJ)V

    iput-object p3, v0, Lchat/ola/vn/network/a/a/t;->c:Lchat/ola/vn/p/c;

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public c(JS)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->c(JS)V

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;)V

    return-void
.end method

.method public c(Ljava/lang/String;Lchat/ola/vn/p/a;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/e;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/e;-><init>(Ljava/lang/String;J)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/network/a/a/e;->a(Lchat/ola/vn/p/a;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-nez p4, :cond_0

    return-void

    :cond_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->o(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/i/i;->a()V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3, p4}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public c(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->n(Ljava/lang/String;S)V

    return-void
.end method

.method public c(Ljava/lang/String;SLjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;SLjava/lang/String;)V

    return-void
.end method

.method public c(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->f(S)V

    return-void
.end method

.method public c([Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->b([Ljava/lang/String;)V

    return-void
.end method

.method public d(J)Lchat/ola/vn/message/f;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->c(J)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object p2, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/message/g;->a(J)Lchat/ola/vn/message/f;

    move-result-object p1

    if-nez p1, :cond_0

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object p2, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v0

    sget-object p2, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/entity/s;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, v0, v1, p2}, Lchat/ola/vn/message/g;->a(JLjava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object p1

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p2

    const/4 v0, 0x1

    invoke-static {p2, v0}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Z)V

    return-object p1
.end method

.method public d()V
    .locals 5
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    sget-boolean v0, Lchat/ola/vn/h;->F:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x2

    iput v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, p0, Lchat/ola/vn/network/OlaNetworkService;->n:J

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/network/f;

    invoke-interface {v2}, Lchat/ola/vn/network/f;->o()V

    goto :goto_0

    :cond_0
    new-instance v0, Lchat/ola/vn/network/g;

    invoke-direct {v0}, Lchat/ola/vn/network/g;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->s:Ljava/lang/String;

    iput-object v2, v0, Lchat/ola/vn/network/g;->a:Ljava/lang/String;

    const/4 v2, 0x0

    iput-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->s:Ljava/lang/String;

    invoke-virtual {v0, v2}, Lchat/ola/vn/network/g;->a(Ljava/lang/Long;)V

    invoke-virtual {v0, p0}, Lchat/ola/vn/network/g;->a(Lchat/ola/vn/network/i;)V

    :try_start_0
    new-instance v2, Lchat/ola/vn/network/h;

    invoke-direct {v2}, Lchat/ola/vn/network/h;-><init>()V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    sget-object v3, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v1, v1, [Lchat/ola/vn/network/g;

    aput-object v0, v1, v4

    invoke-virtual {v2, v3, v1}, Lchat/ola/vn/network/h;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_1
    new-array v1, v1, [Lchat/ola/vn/network/g;

    aput-object v0, v1, v4

    invoke-virtual {v2, v1}, Lchat/ola/vn/network/h;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/message/f;

    invoke-direct {v0, p1, v1}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    :cond_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/message/f;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->g(Ljava/lang/String;Ljava/lang/String;)V

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/h;->h:Z

    :cond_0
    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public d(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->e(Ljava/lang/String;S)V

    return-void
.end method

.method public d(Ljava/lang/String;SLjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->d(Ljava/lang/String;SLjava/lang/String;)V

    return-void
.end method

.method public d(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->h(S)V

    return-void
.end method

.method public d([Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->a([Ljava/lang/String;)V

    return-void
.end method

.method e()V
    .locals 5
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    const-string v0, "OlaNetworkService"

    const-string v1, "-----CLOSE SOCKET-----"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v1}, Lchat/ola/vn/w/ci;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->o()V

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/u/b;->b()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    sget-object v1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v1}, Lchat/ola/vn/balloon/OlaBalloonService;->b()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    new-instance v1, Lchat/ola/vn/network/b;

    invoke-direct {v1}, Lchat/ola/vn/network/b;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->e:Ljava/net/Socket;

    iput-object v2, v1, Lchat/ola/vn/network/b;->a:Ljava/net/Socket;

    const/4 v2, 0x0

    iput-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->e:Ljava/net/Socket;

    iput-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->f:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    new-instance v2, Lchat/ola/vn/network/a;

    invoke-direct {v2}, Lchat/ola/vn/network/a;-><init>()V

    sget-object v4, Landroid/os/AsyncTask;->THREAD_POOL_EXECUTOR:Ljava/util/concurrent/Executor;

    new-array v0, v0, [Lchat/ola/vn/network/b;

    aput-object v1, v0, v3

    invoke-virtual {v2, v4, v0}, Lchat/ola/vn/network/a;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    new-instance v2, Lchat/ola/vn/network/a;

    invoke-direct {v2}, Lchat/ola/vn/network/a;-><init>()V

    new-array v0, v0, [Lchat/ola/vn/network/b;

    aput-object v1, v0, v3

    invoke-virtual {v2, v0}, Lchat/ola/vn/network/a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    return-void
.end method

.method public e(J)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->d(J)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;Z)V

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object p1

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->p()Lchat/ola/vn/entity/s;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/message/g;->a(J)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->c()Lchat/ola/vn/c;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->G()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->v()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/w/ci;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p2}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 PBC @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " #"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_0
    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    return-void

    :cond_0
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@113 PBC.X #"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->d(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public e(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->m(Ljava/lang/String;S)V

    return-void
.end method

.method public e(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->c(S)V

    return-void
.end method

.method public f()V
    .locals 2

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    invoke-interface {v1}, Lchat/ola/vn/network/f;->r()V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->j(Ljava/lang/String;)V

    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p2}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 DS @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " #"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_0
    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    return-void

    :cond_0
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@113 DS.X #"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public f(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public f(Ljava/lang/String;S)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const-string v1, "#"

    const-string v2, ""

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->replaceFirst(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->d(Ljava/lang/String;S)V

    return-void
.end method

.method public f(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->d(S)V

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->i(Ljava/lang/String;)V

    return-void
.end method

.method public g(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 BAN @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " #"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public g(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->g(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public g(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->c(Ljava/lang/String;S)V

    return-void
.end method

.method public g(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->e(S)V

    return-void
.end method

.method public g()Z
    .locals 2

    iget v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public h(Ljava/lang/String;)V
    .locals 5

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->o(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    return-void

    :catch_0
    :cond_0
    :try_start_1
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->k()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {p1}, Lchat/ola/vn/util/m;->n(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    new-instance v2, Lchat/ola/vn/network/OlaNetworkService$2;

    invoke-direct {v2, p0, v0, v1, p1}, Lchat/ola/vn/network/OlaNetworkService$2;-><init>(Lchat/ola/vn/network/OlaNetworkService;JLjava/lang/String;)V

    const-wide/16 v0, 0x7530

    invoke-static {v2, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    sput-object p1, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->g(Ljava/lang/String;)V

    return-void
.end method

.method public h(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 CLEAR @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " #"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->a(Ljava/lang/String;S)V

    return-void
.end method

.method public h(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->i(S)V

    return-void
.end method

.method public h()Z
    .locals 2

    iget v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public h(Ljava/lang/String;Ljava/lang/String;S)Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->j()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "null"

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;SLjava/lang/String;S)V

    return v1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public i(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->v:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_1
    const-string v0, "mem"

    const/4 v1, 0x3

    invoke-direct {p0, v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->m(Ljava/lang/String;Ljava/lang/String;S)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 OK @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " #"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public i(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;S)V

    return-void
.end method

.method public i(S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->j(S)V

    return-void
.end method

.method public i()Z
    .locals 2

    iget v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public i(Ljava/lang/String;Ljava/lang/String;S)Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->j()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string v0, "null"

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, v1, p2, p3}, Lchat/ola/vn/w/ci;->b(Ljava/lang/String;SLjava/lang/String;S)V

    const/4 p1, 0x1

    return p1

    :cond_0
    return v1
.end method

.method public j()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    return v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->h(Ljava/lang/String;)V

    return-void
.end method

.method public j(Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 OK.X @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " #"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public j(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->i(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public j(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->j(Ljava/lang/String;S)V

    return-void
.end method

.method public k()V
    .locals 2

    const-string v0, "OlaNetworkService"

    const-string v1, "-----DISCONNECT-----"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->d(Ljava/lang/String;)V

    return-void
.end method

.method public k(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p2, p1}, Lchat/ola/vn/w/ci;->s(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;)V

    return-void
.end method

.method public k(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->j(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public k(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->l(Ljava/lang/String;S)V

    return-void
.end method

.method public l()V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ak;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/ak;-><init>(J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->o(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->m(Ljava/lang/String;)V

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/message/g;->f(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->e(Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public l(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->h(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public l(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2, p3}, Lchat/ola/vn/w/ci;->e(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public l(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->k(Ljava/lang/String;S)V

    return-void
.end method

.method m()V
    .locals 6

    const-wide/16 v0, 0xbb8

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->h()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/h;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lchat/ola/vn/h;->c()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    invoke-virtual {p0, v2, v3, v4, v5}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v2, Lchat/ola/vn/network/OlaNetworkService$7;

    invoke-direct {v2, p0}, Lchat/ola/vn/network/OlaNetworkService$7;-><init>(Lchat/ola/vn/network/OlaNetworkService;)V

    invoke-static {v2, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    new-instance v2, Lchat/ola/vn/network/OlaNetworkService$8;

    invoke-direct {v2, p0}, Lchat/ola/vn/network/OlaNetworkService$8;-><init>(Lchat/ola/vn/network/OlaNetworkService;)V

    invoke-static {v2, v0, v1}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;

    :cond_0
    return-void
.end method

.method public m(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/w/ci;->f(Ljava/lang/String;S)V

    return-void
.end method

.method public m(Ljava/lang/String;S)V
    .locals 6

    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    packed-switch p2, :pswitch_data_0

    return-void

    :pswitch_0
    :try_start_0
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@113 restrict #"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " view"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    return-void

    :pswitch_1
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@113 restrict #"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " all"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :pswitch_2
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@113 restrict #"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " write"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :pswitch_3
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@113 restrict #"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " join"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :pswitch_4
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@113 restrict #"

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " none"

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public n()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->g()V

    return-void
.end method

.method public n(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->p(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->o(Ljava/lang/String;)V

    return-void
.end method

.method public n(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->p(Ljava/lang/String;S)V

    return-void
.end method

.method public o()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->f()V

    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/w/ci;->g(Ljava/lang/String;S)V

    return-void
.end method

.method public o(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->r(Ljava/lang/String;S)V

    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->d:Lchat/ola/vn/network/d;

    return-object p1
.end method

.method public onCreate()V
    .locals 2

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    new-instance v0, Lchat/ola/vn/w/ci;

    invoke-direct {v0}, Lchat/ola/vn/w/ci;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    new-instance v0, Lchat/ola/vn/network/e;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/e;-><init>(Lchat/ola/vn/network/OlaNetworkService;)V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->h:Lchat/ola/vn/network/e;

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->h:Lchat/ola/vn/network/e;

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/p/g;)V

    sput-object p0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->t:J

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    new-instance v0, Lchat/ola/vn/network/d;

    invoke-direct {v0}, Lchat/ola/vn/network/d;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->d:Lchat/ola/vn/network/d;

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->d:Lchat/ola/vn/network/d;

    invoke-virtual {v0, p0}, Lchat/ola/vn/network/d;->a(Lchat/ola/vn/network/OlaNetworkService;)V

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->i:Landroid/os/Handler;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/f;)V

    invoke-static {}, Lchat/ola/vn/network/OlaNetworkService;->c()V

    invoke-static {}, Lchat/ola/vn/h/b;->b()Ljava/util/List;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/h;->j:Ljava/util/List;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {v0}, Lchat/ola/vn/h/b;->g(Ljava/lang/String;)B

    move-result v1

    sput-byte v1, Lchat/ola/vn/c/x;->m:B

    invoke-static {v0}, Lchat/ola/vn/h/b;->j(Ljava/lang/String;)B

    move-result v1

    sput-byte v1, Lchat/ola/vn/c/x;->n:B

    invoke-static {v0}, Lchat/ola/vn/h/b;->n(Ljava/lang/String;)B

    move-result v1

    sput-byte v1, Lchat/ola/vn/c/x;->o:B

    invoke-static {v0}, Lchat/ola/vn/h/b;->o(Ljava/lang/String;)Z

    move-result v1

    sput-boolean v1, Lchat/ola/vn/c/x;->v:Z

    invoke-static {v0}, Lchat/ola/vn/h/b;->k(Ljava/lang/String;)Z

    move-result v1

    sput-boolean v1, Lchat/ola/vn/c/x;->h:Z

    invoke-static {v0}, Lchat/ola/vn/h/b;->l(Ljava/lang/String;)Z

    move-result v1

    sput-boolean v1, Lchat/ola/vn/c/x;->x:Z

    invoke-static {v0}, Lchat/ola/vn/h/b;->m(Ljava/lang/String;)Z

    move-result v0

    sput-boolean v0, Lchat/ola/vn/c/x;->y:Z

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->z()V

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->C()V

    return-void
.end method

.method public onDestroy()V
    .locals 3

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p0}, Lchat/ola/vn/network/OlaNetworkService;->e()V

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->m:Ljava/lang/Runnable;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->i:Landroid/os/Handler;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->i:Landroid/os/Handler;

    iget-object v2, p0, Lchat/ola/vn/network/OlaNetworkService;->m:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->i:Landroid/os/Handler;

    :cond_0
    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->m:Ljava/lang/Runnable;

    :cond_1
    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/network/OlaNetworkService;->u:Ljava/util/concurrent/ExecutorService;

    invoke-interface {v1}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->u:Ljava/util/concurrent/ExecutorService;

    throw v1

    :catch_0
    :goto_0
    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->u:Ljava/util/concurrent/ExecutorService;

    invoke-direct {p0}, Lchat/ola/vn/network/OlaNetworkService;->D()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    iget p1, p0, Lchat/ola/vn/network/OlaNetworkService;->l:I

    const/4 p2, 0x7

    if-ne p1, p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p1}, Lchat/ola/vn/w/ci;->j()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p1}, Lchat/ola/vn/w/ci;->m()S

    move-result p1

    sput-short p1, Lchat/ola/vn/h;->H:S

    iget-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {p1}, Lchat/ola/vn/w/ci;->k()Ljava/lang/String;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    :cond_0
    const/4 p1, 0x1

    return p1
.end method

.method public p()V
    .locals 6

    const-string v1, "@113 topme.x"

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public p(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->k(Ljava/lang/String;)V

    return-void
.end method

.method public p(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->o(Ljava/lang/String;S)V

    return-void
.end method

.method public q()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->o()V

    return-void
.end method

.method public q(Ljava/lang/String;)V
    .locals 10

    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@113 top.x #"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-wide/16 v4, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v2, p0

    invoke-virtual/range {v2 .. v9}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLjava/lang/String;SLjava/lang/String;S)V

    return-void
.end method

.method public q(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->q(Ljava/lang/String;S)V

    return-void
.end method

.method public r()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/ci;->g(S)V

    return-void
.end method

.method public r(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->m(Ljava/lang/String;)V

    return-void
.end method

.method public r(Ljava/lang/String;S)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lchat/ola/vn/network/OlaNetworkService;->k(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public s()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->d()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/network/OlaNetworkService;->o:J

    return-void
.end method

.method public s(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->n(Ljava/lang/String;)V

    return-void
.end method

.method public s(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->s(Ljava/lang/String;S)V

    return-void
.end method

.method public t()Lchat/ola/vn/network/e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->h:Lchat/ola/vn/network/e;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/network/e;

    invoke-direct {v0, p0}, Lchat/ola/vn/network/e;-><init>(Lchat/ola/vn/network/OlaNetworkService;)V

    iput-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->h:Lchat/ola/vn/network/e;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->h:Lchat/ola/vn/network/e;

    return-object v0
.end method

.method public t(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->q(Ljava/lang/String;)V

    return-void
.end method

.method public t(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->t(Ljava/lang/String;S)V

    return-void
.end method

.method public u()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->r()V

    return-void
.end method

.method public u(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->r(Ljava/lang/String;)V

    return-void
.end method

.method public u(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->u(Ljava/lang/String;S)V

    return-void
.end method

.method public v()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0}, Lchat/ola/vn/w/ci;->q()V

    return-void
.end method

.method public v(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->t(Ljava/lang/String;)V

    return-void
.end method

.method public v(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->v(Ljava/lang/String;S)V

    return-void
.end method

.method public w()V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/ae;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/network/a/a/ae;-><init>(J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method

.method public w(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->u(Ljava/lang/String;)V

    return-void
.end method

.method public w(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->w(Ljava/lang/String;S)V

    return-void
.end method

.method public x()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/w/ci;->d(Z)V

    return-void
.end method

.method x(Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/network/OlaNetworkService;->s:Ljava/lang/String;

    const-string p1, "OlaNetworkService"

    const-string v0, "-----Change SERVER-----"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    return-void
.end method

.method public x(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->y(Ljava/lang/String;S)V

    return-void
.end method

.method public y(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1}, Lchat/ola/vn/w/ci;->l(Ljava/lang/String;)V

    return-void
.end method

.method public y(Ljava/lang/String;S)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/network/OlaNetworkService;->g:Lchat/ola/vn/w/ci;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/w/ci;->x(Ljava/lang/String;S)V

    return-void
.end method

.method public z(Ljava/lang/String;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/network/a/a/af;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-direct {v0, p1, v1, v2}, Lchat/ola/vn/network/a/a/af;-><init>(Ljava/lang/String;J)V

    invoke-direct {p0, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/entity/m;)V

    return-void
.end method
