.class Lchat/ola/vn/note/a$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


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

    iput-object p1, p0, Lchat/ola/vn/note/a$3;->a:Lchat/ola/vn/note/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/c;->a(Landroid/content/Context;)V

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/note/OlaNoteComposerActivity;->e:Lchat/ola/vn/note/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
