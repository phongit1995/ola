.class Lchat/ola/vn/c/t$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/concurrent/ThreadFactory;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/t;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/t;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/t;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/t$1;->a:Lchat/ola/vn/c/t;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public newThread(Ljava/lang/Runnable;)Ljava/lang/Thread;
    .locals 2

    new-instance v0, Ljava/lang/Thread;

    invoke-direct {v0, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lchat/ola/vn/OlaApplication;->a:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " CacherTask-"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/c/t$1;->a:Lchat/ola/vn/c/t;

    invoke-static {v1}, Lchat/ola/vn/c/t;->a(Lchat/ola/vn/c/t;)I

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/c/t$1;->a:Lchat/ola/vn/c/t;

    invoke-static {p1}, Lchat/ola/vn/c/t;->b(Lchat/ola/vn/c/t;)I

    return-object v0
.end method
