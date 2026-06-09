.class Lchat/ola/vn/note/a$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/note/a;->c()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/note/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/note/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/note/a$2;->a:Lchat/ola/vn/note/a;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x4c

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/c/c;->c(Landroid/content/Context;)V

    iget-object p1, p0, Lchat/ola/vn/note/a$2;->a:Lchat/ola/vn/note/a;

    invoke-static {p1}, Lchat/ola/vn/note/a;->h(Lchat/ola/vn/note/a;)Ljava/lang/Runnable;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/c/c;->a(Landroid/content/Context;)V

    const/4 p1, 0x0

    sput-object p1, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
