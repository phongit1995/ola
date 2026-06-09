.class public Lit/sephiroth/android/library/a/a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lit/sephiroth/android/library/a/a$b;,
        Lit/sephiroth/android/library/a/a$a;
    }
.end annotation


# direct methods
.method public static final a(Landroid/view/View;)Lit/sephiroth/android/library/a/a$a;
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x10

    if-lt v0, v1, :cond_0

    new-instance v0, Lit/sephiroth/android/library/a/c/a;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/a/c/a;-><init>(Landroid/view/View;)V

    return-object v0

    :cond_0
    const/16 v1, 0xe

    if-lt v0, v1, :cond_1

    new-instance v0, Lit/sephiroth/android/library/a/b/a;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/a/b/a;-><init>(Landroid/view/View;)V

    return-object v0

    :cond_1
    new-instance v0, Lit/sephiroth/android/library/a/a$b;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/a/a$b;-><init>(Landroid/view/View;)V

    return-object v0
.end method
