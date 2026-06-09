.class Lchat/ola/vn/signup/OlaSignUpActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/OlaSignUpActivity;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/OlaSignUpActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/OlaSignUpActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/OlaSignUpActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/OlaSignUpActivity$3;->a:Lchat/ola/vn/signup/OlaSignUpActivity;

    invoke-virtual {v0}, Lchat/ola/vn/signup/OlaSignUpActivity;->C()Lchat/ola/vn/signup/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
