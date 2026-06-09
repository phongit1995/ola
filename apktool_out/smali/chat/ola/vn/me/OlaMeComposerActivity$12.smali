.class Lchat/ola/vn/me/OlaMeComposerActivity$12;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaMeComposerActivity;->E()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaMeComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$12;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/u;)V
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/z;

    invoke-direct {v0}, Lchat/ola/vn/entity/z;-><init>()V

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/entity/z;)Lchat/ola/vn/entity/z;

    invoke-static {}, Lchat/ola/vn/me/OlaMeComposerActivity;->B()Lchat/ola/vn/entity/z;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->c()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/me/OlaMeComposerActivity;->B()Lchat/ola/vn/entity/z;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->j()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/me/OlaMeComposerActivity;->B()Lchat/ola/vn/entity/z;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->g()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/me/OlaMeComposerActivity;->B()Lchat/ola/vn/entity/z;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->d()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$12;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 0

    const/4 p1, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/entity/z;)Lchat/ola/vn/entity/z;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$12;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
