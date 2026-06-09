.class public Lcom/mg/ola/common/b/d;
.super Lcom/mg/ola/common/b/a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/mg/ola/common/b/a<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/b/a;-><init>(Landroid/content/Context;I)V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/b/d;->c()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mg/ola/common/b/d;->a()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/b/d;->b()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mg/ola/common/b/d;->a()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    return-void
.end method
