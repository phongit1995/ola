.class public Lcom/mg/ola/common/b/b;
.super Lcom/mg/ola/common/b/a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/mg/ola/common/b/a<",
        "Ljava/lang/Integer;",
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
.method public a(Ljava/lang/Integer;)Ljava/lang/Integer;
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/b/b;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-virtual {p0}, Lcom/mg/ola/common/b/b;->c()Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1, v0, p1}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1
.end method

.method public b(Ljava/lang/Integer;)V
    .locals 2

    invoke-virtual {p0}, Lcom/mg/ola/common/b/b;->b()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mg/ola/common/b/b;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    return-void
.end method
